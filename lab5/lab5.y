/*
    Devon Sookhoo
    September 2nd, 2025
    Lab 5 ALGO-C
    Enhancements:
				1. Caught error in rule #3, #4, & #11 var-declaration(s)
				2. Added Function Prototypes
				3. Print every T_ID
				4. Print every string for write
*/

%{



/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include "symtable.h"

#define MAX_VARIABLES 4
#define ERROR -1

/* declare function prototype to resolve warning */
int yylex(void);
int regs[MAX_VARIABLES]; // values[address] = value
int variable_count = 0; // how variables many are defined
extern int line_num;
int debugsw=0;

void log_string(char* rule, char* t_string) {
	printf("Rule %s: \t line: %d \t T_STRING: %s\n", rule, line_num, t_string);
}

void log_token(char* rule, char* type, char* token) {
	printf("Rule %s: \t line: %d \t %s: %s\n", rule, line_num, type, token);
}

void log_id(char* rule_number, char* t_id) {
	// printf("Rule %s: \t line: %d \t T_ID: %s\n", rule_number, line_num, t_id);
	// printf("calling log_token:\n");
	log_token(rule_number, "T_ID", t_id);
}

void log_t_num(char* rule_number, int t_num) {
	printf("Rule %s: \t line: %d \t T_NUM: %d\n", rule_number, line_num, t_num);
}

void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  printf ("%s on line number %d\n", s, line_num);
}


%}
/*  defines the start symbol, what values come back from LEX and how the operators are associated  */

%start Program

%union
{
	int value;
	char* string;
}

/* The Expected Tokens From Lex */
%token <value> T_NUM
%token <string> T_ID T_STRING
%token T_INT T_VOID T_BOOLEAN
%token T_WRITE T_READ T_RETURN
%token T_TRUE T_FALSE T_NOT T_AND T_OR
%token T_GE T_LE T_NE T_EQ T_LT T_GT
%token T_BEGIN T_END T_IF T_THEN T_ENDIF T_WHILE T_DO T_ELSE


%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
//%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */

/* Rule #1 */
Program: Declaration_List
			{ printf("============= Successful Parse! =============\n"); };

/* Rule #2 */
Declaration_List: Declaration
								| Declaration_List Declaration;

/* Rule #3 */
Declaration: Var_Declaration
					 | Func_Declaration
					 | Func_Prototype;


/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';';

/* Rule 4a */
Var_List: T_ID 															{ log_id("4a", $1); }
        | T_ID '[' T_NUM ']'								{ log_id("4a", $1); }
				| T_ID ',' Var_List									{ log_id("4a", $1); }
				| T_ID '[' T_NUM ']' ',' Var_List		{ log_id("4a", $1); };

/* Rule #5 */
Type_Specifier: T_INT
							| T_VOID
							| T_BOOLEAN;

/* Rule #6 */
Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt
	{ log_id("6", $2); };

/* Rule #7 */
Params: T_VOID
      | Param_List;

/* Rule #8 */
Param_List: Param
				  | Param ',' Param_List;

/* Rule #9 */
Param: Type_Specifier T_ID 						{ log_id("9", $2); }
			| Type_Specifier T_ID '[' ']' 	{ log_id("9", $2); };

/* Rule #10 */
Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END;

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations
                  |  /* empty */;

/* Rule #12 */
Statement_List: Statement Statement_List
              | /* empty */;

/* Rule #13 */
Statement: Expression_Stmt
				 | Compound_Stmt		
				 | Selection_Stmt
				 | Iteration_Stmt
				 | Assignment_Stmt
				 | Return_Stmt
         | Write_Stmt
         | Read_Stmt;

/* Rule #14 */
Expression_Stmt: Expression ';'
 							 | ';';

/* Rule #15 */
Selection_Stmt: T_IF Expression T_THEN Statement T_ENDIF
              | T_IF Expression T_THEN Statement T_ELSE Statement T_ENDIF;

/* Rule #16 */
Iteration_Stmt: T_WHILE Expression T_DO Statement;

/* Rule #17 */
Return_Stmt: T_RETURN ';'
					 | T_RETURN Expression ';';

/* Rule #18 */
Read_Stmt: T_READ Variable ';';

/* Rule #19 */
Write_Stmt: T_WRITE Expression ';'
					| T_WRITE T_STRING ';' { log_string("19", $2); };

/* Rule #20 */
Assignment_Stmt: Variable '=' Simple_Expression ';';

/* Rule #21 */
Expression: Simple_Expression;

/* Rule #22 */
Variable: T_ID 										  { log_id("22", $1);}
        | T_ID '[' Expression ']' 	{ log_id("22", $1);}

/* Rule #23 */
Simple_Expression: Additive_Expression
                 | Additive_Expression Relop Additive_Expression;

/* Rule #22 */
Relop: T_LE
     | T_LT
		 | T_GT
		 | T_GE
		 | T_EQ
		 | T_NE;

/* Rule #23 */
Additive_Expression: Term
                   | Additive_Expression Add_Op Term;

/* Rule #24 */
Add_Op: '+'
		  | '-';

/* Rule #25 */
Term: Factor
		| Term Mult_Op Factor;

/* Rule #26 */
Mult_Op: '*'
		   | '/'
		   | T_AND
		   | T_OR;

/* Rule #27 */
Factor: '(' Expression ')'
      | T_NUM  { log_t_num("27", $1); }
			| Variable
			| Call
			| T_TRUE 	{ log_token("27", "T_TRUE", "true"); }
			| T_FALSE { log_token("27", "T_FALSE", "false"); }
			| T_NOT Factor;

/* Rule #28 */
Call: T_ID '(' Args ')' 
			{ log_id("28", $1); };

/* Rule #29 */
Args: Arg_List
    | /* empty */;

/* Rule #30 */
Arg_List: Expression
				| Expression ',' Arg_List;

Func_Prototype: Type_Specifier T_ID '(' Params ')' ';';

%%	/* end of rules, start of program */

/* Specify Return value*/
int main() { 
	yyparse();
}

