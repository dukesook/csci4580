/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST
Enhancements:
		- Removed comments from previous labs
		- #include "string.h" for strcmp
		- #include "emit.h" for EMIT() function
		- Added int main(int argc, char* argv[]) to read in arguments
*/

%{


/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h> // exit()
#include <string.h> // for strcmp
#include "ast.h" // include the AST header file
#include "symtable.h" // include the Symbol Table header file
#include "emit.h" // include the Emit header file

#define MAX_VARIABLES 4 // max number of variables
#define ERROR -1 // error code
#define SCALAR_SIZE 1 // size of scalar variable

/* declare function prototype to resolve warning */
int yylex(void); 		// prototype for the lexing function
extern int line_num; // the current line number
int debugsw=0; 			// debug switch
int LEVEL = 0; 			// how many compoound statements deep are we in
int OFFSET = 0; 		// how many words have we seen at GLOBAL, or inside a function
int GOFFSET = 0; 		// holder for global offset when entering a function
int maxoffset = 0; 	// total number of words a function needs
bool mydebug = false; // debug flag

// Error Handling Function
void yyerror (char* s)  /* Called by yyparse on error */
{
  printf ("%s on line number %d\n", s, line_num);
	exit(1); // exit on error
}


// PRE: generic pointer p
// POST: exits program if p is NULL
static void assert_not_null(void *p) {
	if (!p) {
		printf("ERROR: NULL POINTER ENCOUNTERED\n");
		exit(1);
	}
}

// PRE: name to search, level to search at, recur for recursive search
// POST: exits program if symbol is found
static void assert_doesnt_exist(char name[], int level, bool recur) {
  if (Search(name, level, recur)) {
    yyerror(name);
    yyerror("already defined");
  }
}

// PRE: name to search, level to search at, recur for recursive search
// POST: returns symbol if found, else exits program
static struct SymbTab* assert_exists(char name[], int level) {
	bool recursive = true;
	struct SymbTab* p = Search(name, level, recursive);
	if (!p) {
		yyerror(name);
		yyerror("not defined");
	}
	return p;
}

// PRE: symbol to check, expected subtype
// POST: exits program if symbol subtype does not match expected subtype
static void assert_subtype(struct SymbTab* symbol, enum SYMBOL_SUBTYPE subtype) {
	assert_not_null(symbol);
	if (symbol->SubType != subtype) {
		const char* correct_subtype = subtype_to_string(subtype);
		const char* actual_subtype = subtype_to_string(symbol->SubType);
		printf("expected subtype: %s, but got subtype: %s\n", correct_subtype, actual_subtype);
		yyerror(symbol->name);
	}
}

// PRE: AST node to check, expected datatype
// POST: exits program if AST node datatype does not match expected datatype
static void assert_datatype(ASTnode* p, enum DataTypes datatype) {
	assert_not_null(p);
	if (p->datatype != datatype) {
		yyerror(p->name);
		const char* correct_datatype = DataTypes_to_string(datatype);
		const char* actual_datatype = DataTypes_to_string(p->datatype);
		printf("expected datatype: %s, but got datatype: %s\n", correct_datatype, actual_datatype);
		exit(1);
	}
}

// PRE: two AST nodes to compare
// POST: exits program if AST node datatypes do not match
static void assert_same_datatype(ASTnode* p1, ASTnode* p2) {
	assert_not_null(p1);
	assert_not_null(p2);
	if (p1->datatype != p2->datatype) {
		yyerror(p1->name);
		yyerror(p2->name);
		const char* datatype1 = DataTypes_to_string(p1->datatype);
		const char* datatype2 = DataTypes_to_string(p2->datatype);
		printf("datatype mismatch: %s vs %s\n", datatype1, datatype2);
		
		exit(1);
	}
}

// PRE: AST node to check, expected nodetype
// POST: exits program if AST node nodetype does not match expected nodetype
static void assert_nodetype(ASTnode* p, enum ASTtype nodetype) {
	assert_not_null(p);
	if (p->nodetype != nodetype) {
		yyerror(p->name);
		const char* correct_nodetype = ASTtype_to_string(nodetype);
		const char* actual_nodetype = ASTtype_to_string(p->nodetype);
		printf("expected nodetype: %s, but got nodetype: %s\n", correct_nodetype, actual_nodetype);
		exit(1);
	}
}

// PRE: name, datatype, subtype, level, size
// POST: inserts symbol into symbol table, returns pointer to symbol
static SymbTab* yy_insert(char *name, enum DataTypes datatype, enum SYMBOL_SUBTYPE subtype, int level, int size) {
	assert_doesnt_exist(name, level, false);
	SymbTab* symbol;
	symbol = Insert(name, datatype, subtype, level, size, OFFSET);
	OFFSET += size;
	return symbol;
}

// PRE: level to delete
// POST: deletes symbols at level from symbol table, updates OFFSET
static void yy_delete(int level) {
	int removed_size = Delete(level);
	OFFSET -= removed_size;
}

// PRE: params AST node representing function parameters
// POST: returns count of parameters
static int count_params(ASTnode *params) {
	if (!params) {
		return 0;
	} else if (params->nodetype == A_VOID_PARAM) {
		return 0;
	}

	assert_nodetype(params, A_PARAM); // ensure datatype is valid
	
	return 1 + count_params(params->s1);
}


// PRE: args AST node representing function arguments
// POST: returns count of arguments
static int count_args(ASTnode *arg) {
	// s1 is the argument (expression)
	// s2 is the next A_ARGUMENT
	if (!arg) {
		return 0;
	}

	assert_nodetype(arg, A_ARGUMENT);

	if (!arg->s1) {
		printf("ERROR! Argument node with no expression (s1)\n");
		exit(1);
	}

	return 1 + count_args(arg->s2);
}

// PRE: AST node representing variable/expression
// POST: returns size of array
// 0 if scalar
static int get_array_size(ASTnode* p) {
	assert_not_null(p);
	
	switch (p->nodetype) {
		case A_NUMBER:
		case A_EXPRESSION:
		case A_FUNCTION_CALL: // ASTnode->value is not used for functions
			return 0; // Scalar
		case A_VARIABLE:
		  if (p->value == -1) { // value is uninitialized
				printf("ERROR: get_array_size: value not set for variable: %s\n", p->name);
				exit(1);
			}
			return p->value;
		default:
			printf("ERROR: get_array_size() unhandled nodetype: %s\n", ASTtype_to_string(p->nodetype));
			exit(1);
	}
	return -1; // should never reach here
}

// PRE: Two lists that represent FORMALS and ACTUALS
// POST: returns true if they match (length and type), false if they don't.
static bool assert_params_match(ASTnode *params1, ASTnode *params2) {
	if (!params1 && !params2) {
		return true; // both are empty
	} else if (!params1 || !params2) {
		return false; // one is empty, the other is not
	}

	// Parameters Count
	int params1_count = count_params(params1);
	int params2_count = count_params(params2);
	if (params1_count != params2_count) {
		return false;
	}
	
	if (params1_count == 0 && params2_count == 0) {
		return true; // both are empty
	}
	
	// Compare Types
	if (params1->datatype != params2->datatype) {
		return false; // types do not match
	}

	// Compare Array vs Scalar
	assert_not_null(params1->symbol);
	assert_not_null(params2->symbol);
	if (params1->symbol->SubType != params2->symbol->SubType) {
		return false; // one is array, the other is not
	}

	bool children_match = assert_params_match(params1->s1, params2->s1);

}

// PRE: Two lists that represent FORMALS and ACTUALS
// POST: returns 1 if they match (length and type), 0 if they don't.
static bool check_params(ASTnode *params, ASTnode *args) {
	// param1 = Function Definition Parameters
	// param2 = Function call Arguments

	if (!params && !args) {
		return true; // both are empty
	} else if (!params || !args) {
		// This is handled in count_params/count_args length check
		// params may be A_VOID_PARAM and args may be NULL
	}


	// assert_nodetype(params, A_PARAM); // ensure datatype is valid
	int params_count = count_params(params);
	int args_count = count_args(args);

	// check lengths
	if (params_count != args_count) {
		return false; // lengths do not match
	}

	// both are empty
	if (params_count == 0 && args_count == 0) {
		return true; // both are empty
	}

	// compare type1 & type2
	if (params->datatype != args->datatype) {
		return false; // types do not match
	}

	// compare array vs scalar
	if (params->symbol->SubType != args->symbol->SubType) {
		return false; // one is array, the other is not
	}

	// check children
	bool children_match = check_params(params->s1, args->s2);
	return children_match;
}


%}

/* defines the start symbol, what values come back from LEX and how the operators are associated  */
%start Program

// Define the union for YYSTYPE
// The union must cover all possible types of values that can be returned by the tokens and non-terminals.
%union
{
	int value; // for T_NUM
	char* string; // for T_ID and T_STRING
	ASTnode* node; // for AST nodes
	enum DataTypes datatype; // for data types
	enum OPERATORS operator; // for operators
}

// Tokens
/* The Expected Tokens From Lex */
%token <value> T_NUM // integer number
%token <string> T_ID T_STRING // identifier and string
%token T_INT T_VOID T_BOOLEAN
%token T_WRITE T_READ T_RETURN
%token T_TRUE T_FALSE T_NOT
%token T_BEGIN T_END T_IF T_THEN T_ENDIF T_WHILE T_DO T_ELSE
%token T_CONTINUE T_BREAK
%token <operator> T_GE T_LE T_NE T_EQ T_LT T_GT T_AND T_OR

// Types
//  - The %type directive is used to specify the type of non-terminal symbols in the grammar.
%type <node> Declaration Declaration_List Var_Declaration
%type <node> Var_List Func_Declaration Compound_Stmt Param Local_Declarations
%type <node> Statement Statement_List Assignment_Stmt Variable
%type <node> Write_Stmt Factor Term Additive_Expression Simple_Expression Expression
%type <node> Params Param_List Read_Stmt Call Args Arg_List Expression_Stmt Iteration_Stmt
%type <node> Selection_Stmt Continue_Stmt Break_Stmt Return_Stmt
%type <node> Fun_Tail
%type <datatype> Type_Specifier
%type <operator> Add_Op Relop Mult_Op


%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
//%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */


/* Rule #1 */
Program: Declaration_List
			{ printf("============= Successful Parse! =============\n"); 
				program = $1;
			};

/* Rule #2 */
Declaration_List: Declaration
		{ 
			$$ = ASTCreateNode(A_DEC_LIST);
			ASTnode* p = $$; // for debugging
			$$->s1 = $1; 		// Variable or Function Declaration
			$$->s2 = NULL; 	// Next A_DEC_LIST (none)
		}
	| Declaration_List Declaration
		{ 
			$$ = ASTCreateNode(A_DEC_LIST);
			ASTnode* p = $$; // for debugging
			$$->s1 = $2; // Variable or Function Declaration
			$$->s2 = $1; // Next A_DEC_LIST
		}
;

/* Rule #3 */
Declaration: Var_Declaration 	{ $$ = $1; } // Pass up the AST node
					 | Func_Declaration { $$ = $1; } // Pass up the AST node
					 ;


/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';' 
	{
		$$ = $2; // Pass up the Var_List node
		ASTnode* p = $2;
		// A Var_List doesn't know it's datatype, so we need to set it here
		while (p != NULL) { // Iterate through the Var_List
			p->datatype = $1; // Set the datatype for each variable
			p->symbol->Declared_Type = $1;
			p = p->s1; // Move to the next variable in the list
		}
	};

/* Rule 4a */
Var_List: T_ID 
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1;
			$$->value = 1; // single variable (not array)
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_SCALAR, LEVEL, SCALAR_SIZE); // insert into symbol table
		}

	| T_ID '[' T_NUM ']'
		{ 
			ASTnode *p = ASTCreateNode(A_VARDEC); // for debugging
			$$ = p;
			$$->name = $1; // variable name
			if ($3 <= 0) {
				yyerror("Array size must be greater than 0");
			}
			$$->value = $3; // array size
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_ARRAY, LEVEL, $3); // insert into symbol table
		}
	| T_ID ',' Var_List	
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1;  // variable name
			$$->value = 1; // single variable (not array)
			$$->s1 = $3; // next variable in list
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_SCALAR, LEVEL, SCALAR_SIZE); // insert into symbol table
		}
	| T_ID '[' T_NUM ']' ',' Var_List
		{ 
			$$ = ASTCreateNode(A_VARDEC); // array variable
			$$->name = $1; // variable name
			$$->value = $3; // array size
			$$->s1 = $6; // next variable in list
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_ARRAY, LEVEL, $3); // insert into symbol table
		};

/* Rule #5 */
Type_Specifier: T_INT 		{ $$ = A_INTTYPE; } // Pass up the datatype
							| T_VOID 		{ $$ = A_VOIDTYPE; } // Pass up the datatype
							| T_BOOLEAN { $$ = A_BOOLEANTYPE; }; // Pass up the datatype

/* Rule #6 */
Func_Declaration:
	Type_Specifier T_ID '(' 
		{
			SymbTab *p = Search($2, LEVEL, true); // Check if function already exists
			if (p == NULL) {
				// function/protoype not found
				// go ahead and insert it
				Insert($2, $1, SYM_FUNCTION_PRE, LEVEL, 0, 0);
				GOFFSET = OFFSET; // Save global offset
				OFFSET = 2; // we need two memory locations for Stack Pointer and Return Address
				/* maxoffset; */
			} else {
				// function/prototype found
				switch (p->SubType) {
					case SYM_FUNCTION: // function already defined
						printf("%s\n", $2);
						yyerror("Function already defined");
					break;

					case SYM_FUNCTION_PROTO:
						// function prototype found
					break;

					default:
						printf("%s\n", $2);
						yyerror("Function declaraction has unknown type");
				}
			}
		}


	Params ')'
		{ 
			// Mid-level actions allows us to have recursive functions
			// Now that the parameters are known, link them to the pre function
			SymbTab* pre_function = Search($2, LEVEL, false);
			assert_not_null(pre_function);
			
			if (pre_function->SubType == SYM_FUNCTION_PROTO) {
				// Prototype found!
				bool match = assert_params_match(pre_function->fparms, $5); // Check if parameters match
				if (!match) {
					// Parameters do not match
					yyerror("Function parameters do not match prototype");
				}
			}
			ASTnode* params = $5; // for debugging
			pre_function->fparms = $5; // link parameters to symbol table entry


		}

	Fun_Tail
		{
			ASTnode *p = $8;   // for debugging
			$$ = $8; 					 // Pass up the Fun_Tail node
			$$->datatype = $1; // Return Type
			$$->name = $2;		 // Function Name
			$$->s1 = $5; 		   // Parameters
			$$->symbol = Search($2, LEVEL, false);
			$$->symbol->offset = maxoffset; // the offset is the size of the function
			$$->symbol->mysize = maxoffset; // the size if maxoffset because it includes local variables
			if (p->nodetype == A_PROTOTYPE) {
				// function prototype
				$$->symbol->SubType = SYM_FUNCTION_PROTO;
			} else if (p->nodetype == A_FUNCTIONDEC) {
				// if prototype exists, update to function
				$$->symbol->SubType = SYM_FUNCTION;
			} else {
				yyerror("Function tail has unknown type");
			}
			yy_delete(LEVEL+1); // remove parameters from symbol table
		};

/* NEW: Rule #6a */
Fun_Tail: ';' { $$ = ASTCreateNode(A_PROTOTYPE); }
			| Compound_Stmt // Function Definition (with body)
				{ 
					$$ = ASTCreateNode(A_FUNCTIONDEC);
					$$->s2 = $1; // Function Body
				}
			;

/* Rule #7 */
Params: T_VOID 	{
									$$ = ASTCreateNode(A_VOID_PARAM); // No parameters
									$$->datatype = A_VOIDTYPE;
								}
      | Param_List	{ $$ = $1; } // Pass up the Param_List node
			;

/* Rule #8 */
Param_List: Param
		{ 
			$$ = $1; // Pass up the Param node
		} 
	| Param ',' Param_List
		{	
			$$ = $1; // First parameter
			$$->s1 = $3; // 
		};

/* Rule #9 */
Param: Type_Specifier T_ID 	
		{	
			$$ = ASTCreateNode(A_PARAM); // Create parameter node
			ASTnode* p = $$; // for debugging
			$$->datatype = $1; // Parameter datatype
			$$->name = $2; // Parameter name
			$$->value = 1; // indicates non-array parameter
			$$->symbol = yy_insert($2, $1, SYM_SCALAR, LEVEL+1, SCALAR_SIZE);
		}
	| Type_Specifier T_ID '[' ']' 
		{ 
			$$ = ASTCreateNode(A_PARAM); // Create parameter node
			$$->datatype = $1; // Parameter datatype
			$$->name = $2; // Parameter name
			$$->value = 1; // indicates array parameter
			int size = 1; // arrays are passed as pointers, so size is 1
			$$->symbol = yy_insert($2, $1, SYM_ARRAY, LEVEL+1, size);
		};

/* Rule #10 */
Compound_Stmt: 	T_BEGIN  { LEVEL++; }
								Local_Declarations  Statement_List  T_END 
									{ 
										$$ = ASTCreateNode(A_COMPOUND); // Create compound statement node
										ASTnode* p = $$; // for debugging
										$$->s1 = $3; // Local Declarations
										$$->s2 = $4; // Statement List
										if (OFFSET > maxoffset) {
											maxoffset = OFFSET;
										}
										if (mydebug) {
											Display(); // Requirement: output symbol table at each compound statement
										}
										yy_delete(LEVEL); // remove local variables from symbol table
										LEVEL--; // exit scope
									};

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations
		{
			$$ = $1;
			$$->s1 = $2;
		}
	| { $$ = NULL; }; // No local declarations


/* Rule #12 */
Statement_List: Statement Statement_List	{ $$ = ASTCreateNode(A_STMT_LIST);
																						$$->s1 = $1; // Statement
																						$$->s2 = $2; // The next Statement
																						}
              | /* empty */ { $$ = ASTCreateNode(A_STMT_LIST); } ;

/* Rule #13 */
Statement: Expression_Stmt 	{ $$ = $1; } // Pass up the AST node
				 | Compound_Stmt		{ $$ = $1; } // Pass up the AST node
				 | Selection_Stmt 	{ $$ = $1; } // Pass up the AST node
				 | Iteration_Stmt 	{ $$ = $1; } // Pass up the AST node
				 | Assignment_Stmt 	{ $$ = $1; } // Pass up the AST node
				 | Return_Stmt 			{ $$ = $1; } // Pass up the AST node
         | Write_Stmt 			{ $$ = $1; } // Pass up the AST node
         | Read_Stmt 				{ $$ = $1; } // Pass up the AST node
				 | Continue_Stmt 		{ $$ = $1; } // Pass up the AST node
				 | Break_Stmt 			{ $$ = $1; } // Pass up the AST node
				 ;

/* Rule #14 */
Expression_Stmt: Expression ';' { $$ = ASTCreateNode(A_EXPRESSION_STATEMENT); // Create expression statement node
																	$$->s1 = $1; } // Expression
 							 | ';' { $$ = NULL;} ; // Empty expression statement

/* Rule #15 */
Selection_Stmt: T_IF Expression T_THEN Statement T_ENDIF 
										{ $$ = ASTCreateNode(A_SELECTION_STATEMENT);
											$$->s1 = $2; // Condition
											$$->s2 = ASTCreateNode(A_SELECTION_BODY); // Then branch
											$$->s2->s1 = $4; // Then branch statement
										}
              | T_IF Expression T_THEN Statement T_ELSE Statement T_ENDIF 
										{ $$ = ASTCreateNode(A_SELECTION_STATEMENT);
											$$->s1 = $2; // Condition
											$$->s2 = ASTCreateNode(A_SELECTION_BODY); // Then branch
											$$->s2->s1 = $4; // Then branch statement
											$$->s2->s2 = ASTCreateNode(A_SELECTION_BODY); // Else branch
											$$->s2->s2->s1 = $6; // Else branch statement
										}
							;

/* Rule #16 */
Iteration_Stmt: T_WHILE Expression T_DO Statement
								{ $$ = ASTCreateNode(A_ITERATION_STATEMENT); 
									$$->s1 = $2; // Condition
									$$->s2 = $4; // Body
								};

/* Rule #17 */
Return_Stmt: T_RETURN ';' 						{ $$ = ASTCreateNode(A_RETURN); } // Return without value
					 | T_RETURN Expression ';' 	{	$$ = ASTCreateNode(A_RETURN); // Return with value
																				$$->s1 = $2; } ;

/* Rule #18 */
Read_Stmt: T_READ Variable ';' 	{ $$ = ASTCreateNode(A_READ); // Read statement
																	$$->s1 = $2;
																};

/* Rule #19 */
Write_Stmt: T_WRITE Expression ';' { $$ = ASTCreateNode(A_WRITE); // Write expression
																		 $$->s1 = $2;
																		}
					| T_WRITE T_STRING ';' { $$ = ASTCreateNode(A_WRITE); // Write string
																	 $$->name = $2; };

/* Rule #20 */
Assignment_Stmt: Variable '=' Simple_Expression ';' { 
	$$ = ASTCreateNode(A_ASSIGNMENT_STATEMENT);
	assert_same_datatype($1, $3); // Ensure variable and expression have the same datatype
	$$->s1 = $1; // Variable
	$$->s2 = $3; // Expression
	$$->name = CreateTemp(); // temp variable to hold assigned value
	yy_insert($$->name, $1->datatype, SYM_SCALAR, LEVEL, SCALAR_SIZE); // insert temp variable into symbol table
};

/* Rule #21 */
Expression: Simple_Expression { $$ = $1; }; // Pass up the AST node

/* Rule #22 */
Variable: T_ID 	{ 
		struct SymbTab* p = assert_exists($1, LEVEL); // Ensure variable exists
		
		// bugfix! value may also be array
		//assert_subtype(p, SYM_SCALAR); // Ensure variable is of subtype SYM_SCALAR

		$$ = ASTCreateNode(A_VARIABLE); // Create variable node
		$$->name = $1; // Variable name
		$$->symbol = p; // Link to symbol table entry
		$$->datatype = p->Declared_Type; // Set datatype to the declared type of the variable
		$$->value = 1; // scalar variable
	}

	| T_ID '[' Expression ']'	{ 
		struct SymbTab* symbol = assert_exists($1, LEVEL); // Ensure variable exists
		assert_subtype(symbol, SYM_ARRAY); // Ensure variable is of subtype SYM_ARRAY
		
		ASTnode* p = ASTCreateNode(A_VARIABLE); // for debugging
		$$ = p; // Create array variable node
		$$->name = $1; // Variable name
		$$->s1 = $3; // Index expression
		$$->symbol = symbol; // Link to symbol table entry
		$$->datatype = symbol->Declared_Type; // Set datatype to the declared type of the array
		$$->value = get_array_size($$->s1); // array size
		/* $$->symbol->SubType = SYM_SCALAR; // while T_ID is an array, the result of indexing it is a scalar */
		$$->name = CreateTemp(); // temp variable to hold indexed value
		$$->symbol = yy_insert($$->name, $$->datatype, SYM_SCALAR, LEVEL, SCALAR_SIZE); // insert temp variable into symbol table
		assert_datatype($3, A_INTTYPE); // Ensure index is of integer type
	};

/* Rule #23 */
Simple_Expression: Additive_Expression { $$ = $1;}
	| Simple_Expression Relop Additive_Expression {	
		assert_same_datatype($1, $3); // Only compare operands of the same datatype
		$$ = ASTCreateNode(A_EXPRESSION); // Create expression node
		$$->s1 = $1; // Left operand
		$$->s2 = $3; // Right operand
		$$->operator = $2; // Relational operator
		$$->datatype = A_BOOLEANTYPE; // Result of relational operation is boolean
		$$->name = CreateTemp(); // temp 1/3
		yy_insert($$->name, A_BOOLEANTYPE, SYM_SCALAR, LEVEL, SCALAR_SIZE);
	};

/* Rule #22 */
Relop: T_LE { $$ = A_LE;} // Pass up the operator
     | T_LT { $$ = A_LT;} // Pass up the operator
		 | T_GT { $$ = A_GT;} // Pass up the operator
		 | T_GE { $$ = A_GE;} // Pass up the operator
		 | T_EQ { $$ = A_EQ;} // Pass up the operator
		 | T_NE { $$ = A_NE;} // Pass up the operator
		 ;

/* Rule #23 */
Additive_Expression: Term { $$ = $1; }
	| Additive_Expression Add_Op Term { 
		assert_same_datatype($1, $3); // Only add operands of the same datatype
		$$ = ASTCreateNode(A_EXPRESSION);
		$$->s1 = $1; // Left operand
		$$->s2 = $3; // Right operand
		$$->operator = $2;
		$$->datatype = $1->datatype; // Set datatype
		$$->name = CreateTemp(); // temp 2/3
		$$->symbol = yy_insert($$->name, $$->datatype, SYM_SCALAR, LEVEL, SCALAR_SIZE);
	};

/* Rule #24 */
Add_Op: '+'  	{ $$ = A_PLUS; } // Pass up the operator
		  | '-' 	{ $$ = A_MINUS; }; // Pass up the operator

/* Rule #25 */
Term: Factor { $$ = $1; }
		| Term Mult_Op Factor { 
														// Only multiply operands of the same datatype
														assert_same_datatype($1, $3);
														$$ = ASTCreateNode(A_EXPRESSION);  // Create expression node
														$$->s1 = $1; // Left operand
														$$->s2 = $3; // Right operand
														$$->operator = $2; // Multiplicative operator
														$$->datatype = $1->datatype; // Set datatype
														$$->name = CreateTemp(); // temp 3/3
														$$->symbol = yy_insert($$->name, $$->datatype, SYM_SCALAR, LEVEL, SCALAR_SIZE);
													}; // Pass up the AST node
		;

/* Rule #26 */
Mult_Op: '*' 		{ $$ = A_TIMES; } // Pass up the operator
		   | '/' 		{ $$ = A_DIVIDE; } // Pass up the operator
		   | T_AND 	{ $$ = A_AND; } // Pass up the operator
		   | T_OR 	{ $$ = A_OR; }; // Pass up the operator

/* Rule #27 */
Factor: '(' Expression ')' { $$ = $2; } // Pass up the Expression node
	| T_NUM   			{ 
										$$ = ASTCreateNode(A_NUMBER);
										$$->value = $1;
										$$->datatype = A_INTTYPE;
										$$->name = CreateTemp(); // temp 3/3
										$$->symbol = yy_insert($$->name, $$->datatype, SYM_SCALAR, LEVEL, SCALAR_SIZE);
									}
	| Variable 			{
										$$ = $1;
									}
	| Call 					{
										$$ = $1;
									}
	| T_TRUE 	 			{
										$$ = ASTCreateNode(A_BOOLEAN); 
										$$->value = 1; // true is represented as 1
										$$->datatype = A_BOOLEANTYPE; // Set datatype
									} 
	| T_FALSE  			{
										$$ = ASTCreateNode(A_BOOLEAN);
										$$->value = 0; // false is represented as 0
										$$->datatype = A_BOOLEANTYPE; // Set datatype
									}
	| T_NOT Factor	{ 
										assert_datatype($2, A_BOOLEANTYPE); // Ensure the factor is boolean
										$$ = ASTCreateNode(A_EXPRESSION);
										$$->operator = A_NOT; // NOT operator
										$$->s1 = $2; // Operand
										$$->datatype = A_BOOLEANTYPE; // Result is boolean
									};

/* Rule #28 */
Call: T_ID '(' Args ')'	{	
	int level = 0; // Functions are always at global level
	struct SymbTab* p = assert_exists($1, level); // Ensure function exists
	// check to see if symbol is a function
	if (p->SubType != SYM_FUNCTION &&
			p->SubType != SYM_FUNCTION_PRE) {
		printf("%s is not a function: it's a: %s\n", $1, subtype_to_string(p->SubType));
		yyerror("is not a function");
	} else if (p->SubType == SYM_FUNCTION_PROTO) {
		printf("Prototype function call: %s\n", $1);
		yyerror("calling function prototype");
	}

	// check to see if formals and actuals match in length and type
	// $3 = A_ARG_LIST
	// $3->s1 = first A_ARGUMENT
	ASTnode* arg_list = $3;
	ASTnode* first_arg = arg_list->s1;
	bool match = check_params(p->fparms, first_arg);
	if (!match) {
		printf("function parameters don't match for function: %s\n", $1);
		yyerror($1);
	}

	$$ = ASTCreateNode(A_FUNCTION_CALL); // Create function call node
	$$->name = $1; // Function name
	$$->s1 = $3;  // Arguments
	/* $$->symbol = p; // Link to symbol table entry */
	$$->symbol = yy_insert(CreateTemp(), p->Declared_Type, SYM_SCALAR, LEVEL, SCALAR_SIZE); // temp variable to hold return value
	$$->datatype = $$->symbol->Declared_Type; // Function return type
};

/* Rule #29 */
Args: Arg_List { 	$$ = ASTCreateNode(A_ARG_LIST); // Create argument list node
									$$->s1 = $1; } // Arguments
    				| { $$ = ASTCreateNode(A_ARG_LIST); } // No arguments
						;

/* Rule #30 */
Arg_List: Expression	{ 	
												ASTnode* p = ASTCreateNode(A_ARGUMENT); // for debugging
												$$ = p; // Create argument node
												$$->s1 = $1; // Argument Expression
												$$->s2 = NULL; // No remaining arguments
												$$->datatype = $1->datatype;
												$$->value = get_array_size($1);
												$$->symbol = yy_insert(CreateTemp(), $1->datatype, $1->symbol->SubType, LEVEL, SCALAR_SIZE);
											}
	| Expression ',' Arg_List { 
															ASTnode* p = ASTCreateNode(A_ARGUMENT); // Create argument node
															$$ = p;
															$$->s1 = $1; // Argument Expression
															$$->s2 = $3; // Remaining arguments
															$$->datatype = $1->datatype;
															$$->value = get_array_size($1);
															$$->symbol = yy_insert(CreateTemp(), $1->datatype, $1->symbol->SubType, LEVEL, SCALAR_SIZE);
														};

/* Graduate Student Required Rule */
/* Func_Prototype: Type_Specifier T_ID '(' Params ')' ';' 	
	{ $$ = ASTCreateNode(A_FUNCTION_PROTOTYPE);
		$$->datatype = $1; // Return Type
		$$->name = $2;		 // Function Name
		$$->s1 = $4; 		   // Parameters
	}; */

/* Graduate Student Required Rule */
Continue_Stmt: T_CONTINUE ';' { $$ = ASTCreateNode(A_CONTINUE); } ;

/* Graduate Student Required Rule */
Break_Stmt: T_BREAK ';' { $$ = ASTCreateNode(A_BREAK); } ;


%%	/* end of rules, start of program */

/* The main function which calls yyparse() */
int main(int argc, char* argv[]) { 

	// Local Variables
	char s[100];
	FILE* fp = NULL; // pointer to open file


	for (int i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-d") == 0) {
			mydebug = true;
		}

		if (strcmp(argv[i], "-o") == 0) {
			if (argv[i+1] == NULL) {
				printf("ERROR: -o flag requires a filename argument\n");
				exit(1);
			}  // end if
			strcpy(s, argv[i+1]);
			/* strcat(s, ".asm"); */

			if (mydebug) {
				printf("opening file: %s\n", s);
			}  // end if

			fp = fopen(s, "w");
			if (fp == NULL) {
				printf("ERROR: could not open file: %s\n", s);
				exit(1);
			} // end if

		} // end if "-o"

	} // end for argc

	if (fp == NULL) {
		printf("No filename provided. Must use -o <filename>\n");
		exit(1);
	} // end if fp==NULL


	yyparse();

	if (mydebug) {
		Display();
		ASTprint(0, program); // print the AST
	}
	
	EMIT(program, fp);
	printf("Created file: %s\n", s);

	fclose(fp);
	return 0; // Success
}

