/*
    Devon Sookhoo
    October 13th, 2025
    Lab 6 Abstract Syntax Tree
    Enhancements:
				- Removed comments from previous labs
				- Added ASTNode structure to union
				- #include "ast.h"

*/

%{



/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include "ast.h" // include the AST header file

#define MAX_VARIABLES 4 // max number of variables
#define ERROR -1 // error code

/* declare function prototype to resolve warning */
int yylex(void); // prototype for the lexing function
int variable_count = 0; // how variables many are defined
extern int line_num; // the current line number
int debugsw=0; // debug switch

// Helper Function to log strings
void log_string(char* rule, char* t_string) {
	printf("Rule %s: \t line: %d \t T_STRING: %s\n", rule, line_num, t_string);
}

// Helper Function to log tokens
void log_token(char* rule, char* type, char* token) {
	printf("Rule %s: \t line: %d \t %s: %s\n", rule, line_num, type, token);
}

// Helper Function to log identifiers
void log_id(char* rule_number, char* t_id) {
	// printf("Rule %s: \t line: %d \t T_ID: %s\n", rule_number, line_num, t_id);
	// printf("calling log_token:\n");
	log_token(rule_number, "T_ID", t_id);
}

// Helper Function to log numbers
void log_t_num(char* rule_number, int t_num) {
	printf("Rule %s: \t line: %d \t T_NUM: %d\n", rule_number, line_num, t_num);
}

// Error Handling Function
void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  printf ("%s on line number %d\n", s, line_num);
}


%}

/*  defines the start symbol, what values come back from LEX and how the operators are associated  */
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

/* The Expected Tokens From Lex */
%token <value> T_NUM // integer number
%token <string> T_ID T_STRING // identifier and string
%token T_INT T_VOID T_BOOLEAN
%token T_WRITE T_READ T_RETURN
%token T_TRUE T_FALSE T_NOT T_AND T_OR
%token <operator> T_GE T_LE T_NE T_EQ T_LT T_GT
%token T_BEGIN T_END T_IF T_THEN T_ENDIF T_WHILE T_DO T_ELSE
%token T_CONTINUE T_BREAK

%type <node> Declaration Declaration_List Var_Declaration
%type <node> Var_List Func_Declaration Compound_Stmt Param Local_Declarations
%type <node> Statement Statement_List Assignment_Stmt Variable
%type <node> Write_Stmt Factor Term Additive_Expression Simple_Expression Expression
%type <node> Params Param_List Read_Stmt Call Args Arg_List Expression_Stmt
%type <datatype> Type_Specifier
%type <operator> Add_Op Relop   // Mult_Op


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
Declaration: Var_Declaration { $$ = $1; }
					 | Func_Declaration { $$ = $1; }
					 | Func_Prototype { $$ = NULL; }
					 ;


/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';' {$$ = $2;
																							ASTnode* p = $2;
																							// Why is this done here and not in Var_List?
																							while (p != NULL) {
																								p->datatype = $1;
																								p = p->s1;
																							}
																						};

/* Rule 4a */
Var_List: T_ID 															{ $$ = ASTCreateNode(A_VARDEC);
																							$$->name = $1;
																							$$->value = 0; // single variable (not array)
																						}
        | T_ID '[' T_NUM ']'								{ $$ = ASTCreateNode(A_VARDEC);
																							$$->name = $1;
																							$$->value = $3; // array size

																						}
				| T_ID ',' Var_List									{ $$ = ASTCreateNode(A_VARDEC);
																							$$->name = $1; 
																							$$->value = 0; // single variable (not array)
																							$$->s1 = $3;
																						}
				| T_ID '[' T_NUM ']' ',' Var_List		{ $$ = ASTCreateNode(A_VARDEC);
																							$$->name = $1;
																							$$->value = $3; // array size
																							$$->s1 = $6; 
																						};

/* Rule #5 */
Type_Specifier: T_INT { $$ = A_INTTYPE; }
							| T_VOID { $$ = A_VOIDTYPE; }
							| T_BOOLEAN { $$ = A_BOOLEANTYPE; };

/* Rule #6 */
Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt
	{ $$ = ASTCreateNode(A_FUNCTIONDEC);
		$$->datatype = $1; // Return Type
		$$->name = $2;		 // Function Name
		$$->s1 = $4; 		   // Parameters
		$$->s2 = $6;	 		 // Function Body
	 };

/* Rule #7 */
Params: T_VOID { $$ = ASTCreateNode(A_VOID_PARAM);}
      | Param_List	{ $$ = $1;}
			;

/* Rule #8 */
Param_List: Param { $$ = $1; }
				  | Param ',' Param_List	{	$$ = $1;
															 			$$->s1 = $3; }
					;

/* Rule #9 */
Param: Type_Specifier T_ID 	{	$$ = ASTCreateNode(A_PARAM);
															$$->datatype = $1;
															$$->name = $2; }
			| Type_Specifier T_ID '[' ']' 	{ log_id("9", $2); };

/* Rule #10 */
Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END 
{ 
	$$ = ASTCreateNode(A_COMPOUND);
	$$->s1 = $2; // Local Declarations
	$$->s2 = $3; // Statement List
};

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations	{	$$ = $1;
																													$$->s2 = $2;	}
                  |  /* empty */ { $$ = NULL; }
									;

/* Rule #12 */
Statement_List: Statement Statement_List	{ $$ = ASTCreateNode(A_STMT_LIST);
																						$$->s1 = $1; // Statement
																						$$->s2 = $2; // The next Statement
																						}
              | /* empty */ { $$ = ASTCreateNode(A_STMT_LIST); } ;

/* Rule #13 */
Statement: Expression_Stmt { $$ = $1; }
				 | Compound_Stmt		{ $$ = NULL; }
				 | Selection_Stmt { $$ = NULL; }
				 | Iteration_Stmt { $$ = NULL; }
				 | Assignment_Stmt { $$ = NULL; }
				 | Return_Stmt { $$ = NULL; }
         | Write_Stmt { $$ = $1; }
         | Read_Stmt { $$ = $1; }
				 | Continue_Stmt { $$ = NULL; }
				 | Break_Stmt { $$ = NULL; }
				 ;

/* Rule #14 */
Expression_Stmt: Expression ';' { $$ = $1; }
 							 | ';' { $$ = NULL;} ;

/* Rule #15 */
Selection_Stmt: T_IF Expression T_THEN Statement T_ENDIF
              | T_IF Expression T_THEN Statement T_ELSE Statement T_ENDIF;

/* Rule #16 */
Iteration_Stmt: T_WHILE Expression T_DO Statement;

/* Rule #17 */
Return_Stmt: T_RETURN ';'
					 | T_RETURN Expression ';';

/* Rule #18 */
Read_Stmt: T_READ Variable ';' { 	$$ = ASTCreateNode(A_READ);
																	$$->s1 = $2;
																		} ;

/* Rule #19 */
Write_Stmt: T_WRITE Expression ';' { $$ = ASTCreateNode(A_WRITE);
																		 $$->s1 = $2;
																		}
					| T_WRITE T_STRING ';' { $$ = ASTCreateNode(A_WRITE);
																	 $$->name = $2; };

/* Rule #20 */
Assignment_Stmt: Variable '=' Simple_Expression ';' { $$ = $1;};

/* Rule #21 */
Expression: Simple_Expression { $$ = $1; };

/* Rule #22 */
Variable: T_ID 										  { $$ = ASTCreateNode(A_VARIABLE);
																			$$->name = $1; }
        | T_ID '[' Expression ']' 	{ $$ = ASTCreateNode(A_VARIABLE);
																			$$->name = $1;
																			$$->s1 = $3; };

/* Rule #23 */
Simple_Expression: Additive_Expression { $$ = $1;}
                 | Simple_Expression Relop Additive_Expression {	$$ = ASTCreateNode(A_EXPRESSION);
								 																									$$->s1 = $1;
																									 								$$->s2 = $3;
																									 								$$->operator = $2; };

/* Rule #22 */
Relop: T_LE { $$ = A_LE;}
     | T_LT { $$ = A_LT;}
		 | T_GT { $$ = A_GT;}
		 | T_GE { $$ = A_GE;}
		 | T_EQ { $$ = A_EQ;}
		 | T_NE { $$ = A_NE;}
		 ;

/* Rule #23 */
Additive_Expression: Term { $$ = $1; }
                   | Additive_Expression Add_Op Term { $$ = ASTCreateNode(A_EXPRESSION);
									 																		 $$->s1 = $1;
																											 $$->s2 = $3;
																											 $$->operator = $2; };

/* Rule #24 */
Add_Op: '+'  { $$ = A_PLUS; }
		  | '-' { $$ = A_MINUS; };

/* Rule #25 */
Term: Factor { $$ = $1; }
		| Term Mult_Op Factor { $$ = NULL; } ;

/* Rule #26 */
Mult_Op: '*'
		   | '/'
		   | T_AND
		   | T_OR;

/* Rule #27 */
Factor: '(' Expression ')' { $$ = $2; }
      | T_NUM   { $$ = ASTCreateNode(A_NUMBER);
								  $$->value = $1; }
			| Variable { $$ = $1; }
			| Call { $$ = $1; }
			| T_TRUE 	 { $$ = NULL; }
			| T_FALSE  { $$ = NULL; }
			| T_NOT Factor	{ $$ = ASTCreateNode(A_EXPRESSION);
												$$->operator = A_NOT;
												$$->s1 = $2; };

/* Rule #28 */
Call: T_ID '(' Args ')'	{	$$ = ASTCreateNode(A_FUNCTION_CALL);
													$$->name = $1;
													$$->s1 = $3; 
													} ;

/* Rule #29 */
Args: Arg_List { $$ = $1; }
    | /* empty */ { $$ = NULL; } ;

/* Rule #30 */
Arg_List: Expression { $$ = $1; }
				| Expression ',' Arg_List { $$ = NULL;};

/* Graduate Student Required Rule */
Func_Prototype: Type_Specifier T_ID '(' Params ')' ';' {log_id("Func_Prototype", $2);};

/* Graduate Student Required Rule */
Continue_Stmt: T_CONTINUE ';' { log_token("Continue_Stmt", "T_CONTINUE", "continue"); } ;

/* Graduate Student Required Rule */
Break_Stmt: T_BREAK ';' { log_token("Break_Stmt", "T_BREAK", "break"); } ;

%%	/* end of rules, start of program */

/* The main function which calls yyparse() */
int main() { 
	yyparse();

	// Sets the program variable to an AST.

	ASTprint(0, program); // print the AST
	
	return 0;
}

