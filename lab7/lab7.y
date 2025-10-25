/*
Devon Sookhoo
October 27th, 2025
Lab 7 Add Symbol Table and Type Checking
Enhancements:
		- Removed comments from previous labs
		- #include "symtable.h"
		- Created function assert_doesnt_exist()
		- #include <assert.h>

*/

%{



/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h> // exit()
#include "ast.h" // include the AST header file
#include "symtable.h" // include the Symbol Table header file

#define MAX_VARIABLES 4 // max number of variables
#define ERROR -1 // error code
#define SCALAR_SIZE 1 // size of scalar variable

/* declare function prototype to resolve warning */
int yylex(void); // prototype for the lexing function
extern int line_num; // the current line number
int debugsw=0; 		// debug switch
int LEVEL = 0; 		// how many compoound statements deep are we in
int OFFSET = 0; 	// how many words have we seen at GLOBAL, or inside a function
int GOFFSET = 0; 	// holder for global offset when entering a function
int maxoffset = 0; // total number of words a function needs

// Error Handling Function
void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  printf ("%s on line number %d\n", s, line_num);
}

static void assert_not_null(void *p) {
	if (!p) {
		printf("ERROR: NULL POINTER ENCOUNTERED\n");
		exit(1);
	}
}

// TODO - comments
static void assert_doesnt_exist(char name[], int level, bool recur) {
  if (Search(name, level, recur)) {
    yyerror(name);
    yyerror("already defined");
    exit(1);
  }
}

// TODO - comments
static struct SymbTab* assert_exists(char name[], int level) {
	bool recursive = true;
	struct SymbTab* p = Search(name, level, recursive);
	if (!p) {
		yyerror(name);
		yyerror("not defined");
		exit(1);
	}
	return p;
}

// TODO - comments
static void assert_subtype(struct SymbTab* symbol, enum SYMBOL_SUBTYPE subtype) {
	assert_not_null(symbol);
	if (symbol->SubType != subtype) {
		yyerror(symbol->name);
		const char* correct_subtype = subtype_to_string(subtype);
		const char* actual_subtype = subtype_to_string(symbol->SubType);
		printf("expected subtype: %s, but got subtype: %s\n", correct_subtype, actual_subtype);
		exit(1);
	}
}

// TODO - comments
// int, void, or boolean
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

// TODO - comments
static SymbTab* yy_insert(char *name, enum DataTypes datatype, enum SYMBOL_SUBTYPE subtype, int level, int size) {
	assert_doesnt_exist(name, level, false);
	SymbTab* symbol;
	symbol = Insert(name, datatype, subtype, level, size, OFFSET);
	OFFSET += size;
	return symbol;
}


static int count_params(ASTnode *params) {
	if (!params) {
		return 0;
	} else if (params->nodetype == A_VOID_PARAM) {
		return 0;
	}

	assert_nodetype(params, A_PARAM); // ensure datatype is valid
	
	// printf("Parameter:\n");
	// printf("  Name: %s\n", params->name);
	// printf("  DataType: %s\n", DataTypes_to_string(params->datatype));
	// printf("  value: %d\n", params->value); // indicates array or not
	
	return 1 + count_params(params->s1);


}


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

// TODO - comments
// PRE: Two lists that represent FORMALS and ACTUALS
// POST: returns 1 if they match (length and type), 0 if they don't.
static bool check_params(ASTnode *params, ASTnode *args) {
	// param1 = Function Definition Parameters
	// param2 = Function call Arguments

	if (!params) {
		printf("ERROR: params is NULL instead of A_VOID_PARAM\n");
		exit(1);
	}


	// assert_nodetype(params, A_PARAM); // ensure datatype is valid
	int params_count = count_params(params);
	printf("Param count: %d\n", params_count);

	int args_count = count_args(args);
	printf("Arg count: %d\n", args_count);

	if (params_count != args_count) {
		return false; // lengths do not match
	}

	if (params_count == 0 && args_count == 0) {
		return true; // both are empty
	}

	if (!args) {
		printf("Warning! args is NULL\n");
		// TODO
	}

	// compare type1 & type2
	if (params->datatype != args->datatype) {
		return false; // types do not match
	}

	if (params->value != args->value) {
		return false; // one is array, the other is not
	}



	bool children_match = check_params(params->s1, args->s1);
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
Declaration_List: Declaration { $$ = ASTCreateNode(A_DEC_LIST);
																$$->s1 = $1; }
								| Declaration_List Declaration {  $$ = ASTCreateNode(A_DEC_LIST);
																									$$->s1 = $1;
																									$$->s2 = $2; }
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
		while (p != NULL) { // Iterate through the Var_List
			p->datatype = $1; // Set the datatype for each variable
			/* p->symbol->Declared_Type = $1; */
			p = p->s1; // Move to the next variable in the list
		}
	};

/* Rule 4a */
Var_List: T_ID 
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1;
			$$->value = 0; // single variable (not array)
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_SCALAR, LEVEL, SCALAR_SIZE);
		}

	| T_ID '[' T_NUM ']'
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1;
			$$->value = $3; // array size
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_ARRAY, LEVEL, $3);
		}
	| T_ID ',' Var_List	
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1; 
			$$->value = 0; // single variable (not array)
			$$->s1 = $3;
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_SCALAR, LEVEL, SCALAR_SIZE);
		}
	| T_ID '[' T_NUM ']' ',' Var_List
		{ 
			$$ = ASTCreateNode(A_VARDEC);
			$$->name = $1;
			$$->value = $3; // array size
			$$->s1 = $6;
			$$->symbol = yy_insert($1, A_DATATYPE_UNKNOWN, SYM_ARRAY, LEVEL, $3);
		};

/* Rule #5 */
Type_Specifier: T_INT 		{ $$ = A_INTTYPE; } // Pass up the datatype
							| T_VOID 		{ $$ = A_VOIDTYPE; } // Pass up the datatype
							| T_BOOLEAN { $$ = A_BOOLEANTYPE; }; // Pass up the datatype

/* Rule #6 */
Func_Declaration:
	Type_Specifier T_ID '(' 
		{
			assert_doesnt_exist($2, LEVEL, false);
			/* yy_insert($2, $1, SYM_FUNCTION, LEVEL, 0, 0); */
			Insert($2, $1, SYM_FUNCTION, LEVEL, 0, 0);
			GOFFSET = OFFSET; // Save global offset
			OFFSET = 2; // we need two memory locations for Stack Pointer and Return Address
			maxoffset;
		}


	Params ')'
		{
			// Update Symbol Table with parameter
			// allows us to have recursive functions
			Search($2, LEVEL, false)->fparms = $5;
		}

	Fun_Tail
		{ 
			$$ = $8; 					 // Pass up the Fun_Tail node
			$$->datatype = $1; // Return Type
			$$->name = $2;		 // Function Name
			$$->s1 = $5; 		   // Parameters
			$$->symbol = Search($2, LEVEL, false);
			$$->symbol->offset = maxoffset;
		};

/* NEW: Rule #6a */
Fun_Tail: ';' { $$ = ASTCreateNode(A_FUNCTIONDEC); }
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
Param_List: Param { $$ = $1; } // Pass up the Param node
				  | Param ',' Param_List	{	$$ = $1; // First parameter
															 			$$->s1 = $3; }
					;

/* Rule #9 */
Param: Type_Specifier T_ID 	{	
															$$ = ASTCreateNode(A_PARAM);
															$$->datatype = $1;
															$$->name = $2; // Parameter name
															$$->value = 0; // indicates non-array parameter
															$$->symbol = yy_insert($2, $1, SYM_SCALAR, LEVEL+1, SCALAR_SIZE);
														}
			| Type_Specifier T_ID '[' ']' 	{ $$ = ASTCreateNode(A_PARAM);
															$$->datatype = $1;
															$$->name = $2; // Parameter name
															$$->value = 1; // indicates array parameter
															int size = 1;
															$$->symbol = yy_insert($2, $1, SYM_ARRAY, LEVEL+1, size);
															};

/* Rule #10 */
Compound_Stmt: 	T_BEGIN  { LEVEL++; }
								Local_Declarations  Statement_List  T_END 
									{ 
										$$ = ASTCreateNode(A_COMPOUND);
										$$->s1 = $3; // Local Declarations
										$$->s2 = $4; // Statement List
										if (OFFSET > maxoffset) {
											maxoffset = OFFSET;
										}
										OFFSET = OFFSET - Delete(LEVEL);
										LEVEL--;
									};

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations	{	$$ = $1;
																													$$->s2 = $2;	}
                  | { $$ = NULL; } // No local declarations
									;

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
Assignment_Stmt: Variable '=' Simple_Expression ';' { $$ = ASTCreateNode(A_ASSIGNMENT_STATEMENT);
																											$$->s1 = $1; // Variable
																											$$->s2 = $3; // Expression
																											} ;

/* Rule #21 */
Expression: Simple_Expression { $$ = $1; }; // Pass up the AST node

/* Rule #22 */
Variable: T_ID 	{ 
		struct SymbTab* p = assert_exists($1, LEVEL); // Ensure variable exists
		assert_subtype(p, SYM_SCALAR); // Ensure variable is of subtype SYM_SCALAR

		$$ = ASTCreateNode(A_VARIABLE); // Create variable node
		$$->name = $1; // Variable name
		$$->symbol = p; // Link to symbol table entry
		$$->datatype = p->Declared_Type; // Set datatype to the declared type of the variable
	}

	| T_ID '[' Expression ']'	{ 
		struct SymbTab* p = assert_exists($1, LEVEL); // Ensure variable exists
		assert_subtype(p, SYM_ARRAY); // Ensure variable is of subtype SYM_ARRAY
		
		$$ = ASTCreateNode(A_VARIABLE); // Create array variable node
		$$->name = $1; // Variable name
		$$->s1 = $3; // Index expression
		$$->symbol = p; // Link to symbol table entry
		$$->datatype = p->Declared_Type; // Set datatype to the declared type of the array
	}; // Expression for the index

/* Rule #23 */
Simple_Expression: Additive_Expression { $$ = $1;}
                 | Simple_Expression Relop Additive_Expression {	$$ = ASTCreateNode(A_EXPRESSION);
								 																									$$->s1 = $1;
																									 								$$->s2 = $3;
																									 								$$->operator = $2; };

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
                   | Additive_Expression Add_Op Term { $$ = ASTCreateNode(A_EXPRESSION);
									 																		 $$->s1 = $1; // Left operand
																											 $$->s2 = $3; // Right operand
																											 $$->operator = $2; }; // Pass up the AST node

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
														$$->operator = $2;
														$$->datatype = $1->datatype; // Set datatype
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
										$$->datatype = A_BOOLEANTYPE;
									} 
	| T_FALSE  			{
										$$ = ASTCreateNode(A_BOOLEAN);
										$$->value = 0; // false is represented as 0
										$$->datatype = A_BOOLEANTYPE;
									}
	| T_NOT Factor	{ 
										assert_datatype($2, A_BOOLEANTYPE); // Ensure the factor is boolean
										$$ = ASTCreateNode(A_EXPRESSION);
										$$->operator = A_NOT;
										$$->s1 = $2;
										$$->datatype = A_BOOLEANTYPE;
									};

/* Rule #28 */
Call: T_ID '(' Args ')'	{	
	int level = 0; // Functions are always at global level
	struct SymbTab* p = assert_exists($1, level); // Ensure function exists
	assert_subtype(p, SYM_FUNCTION); // Ensure symbol is of subtype SYM_FUNCTION

	// check to see if formals and actuals match in length and type
	// $3 = A_ARG_LIST
	// $3->s1 = first A_ARGUMENT
	bool match = check_params(p->fparms, $3->s1);
	if (!match) {
		yyerror($1);
		yyerror("function parameters do not match");
		exit(1);
	}

	$$ = ASTCreateNode(A_FUNCTION_CALL); // Create function call node
	$$->name = $1; // Function name
	$$->s1 = $3;  // Arguments
	$$->symbol = p; // Link to symbol table entry
	$$->datatype = $$->symbol->Declared_Type; // Function return type
};

/* Rule #29 */
Args: Arg_List { 	$$ = ASTCreateNode(A_ARG_LIST); // Create argument list node
									$$->s1 = $1; } // Arguments
    				| { $$ = ASTCreateNode(A_ARG_LIST); } // No arguments
						;

/* Rule #30 */
Arg_List: Expression	{ 	
												$$ = ASTCreateNode(A_ARGUMENT); // Create argument node
												$$->s1 = $1;
												$$->datatype = $1->datatype;
											} // Single argument
	| Expression ',' Arg_List { $$ = ASTCreateNode(A_ARGUMENT); // Create argument node
															$$->s1 = $1; // First argument
															$$->s2 = $3; // Remaining arguments
															$$->datatype = $1->datatype;
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
int main() { 
	yyparse();

	Display();

	// Sets the program variable to an AST.

	ASTprint(0, program); // print the AST
	
	return 0; // Success
}

