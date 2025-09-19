/*
    Devon Sookhoo
    September 2nd, 2025
    Lab 5 ALGO-C
    Enhancements:
				1. Caught error in rule #3, #4, & #11 var-declaration(s)
				2.
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
Program: Declaration_List;

/* Rule #2 */
Declaration_List: Declaration
								| Declaration_List Declaration;

/* Rule #3 */
Declaration: Var_Declaration
					 | Func_Declaration;

/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';';

/* Rule 4a */
Var_List: T_ID
						{ printf("YACC %d: rule #4a-1: %s\n", line_num, $1); }
        | T_ID '[' T_NUM ']'
						{ printf("YACC %d: rule #4a-2: %s[%d]\n", line_num, $1, $3); }
				| T_ID ',' Var_List
						{ printf("YACC %d: rule #4a-3: %s\n", line_num, $1); }
				| T_ID '[' T_NUM ']' ',' Var_List;

/* Rule #5 */
Type_Specifier: T_INT
							| T_VOID
							| T_BOOLEAN;

/* Rule #6 */
Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt
	{printf("YACC %d: rule #6: %s\n", line_num, $2); };

/* Rule #7 */
Params: T_VOID {printf("rule #7a\n");}
      | Param_List {printf("rule #7b\n");};

/* Rule #8 */
Param_List: Param {printf("rule #8a\n");}
				  | Param ',' Param_List {printf("rule #8b\n");};

/* Rule #9 */
Param: Type_Specifier T_ID
			| Type_Specifier T_ID '[' ']';

/* Rule #10 */
Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END;

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations
                  |  /* empty */;

/* Rule #12 */
Statement_List: Statement Statement_List
              | /* empty */;

/* Rule #13 */
Statement: Expression_Stmt {printf("rule #13 - Expression_Statmement\n");}
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
					| T_WRITE T_STRING ';'
			        { printf("found a string in WRITE with value %s on line %d\n", $2, line_num); } ;

/* Rule #20 */
Assignment_Stmt: Variable '=' Simple_Expression ';';

/* Rule #21 */
Expression: Simple_Expression;

/* Rule #22 */
Variable: T_ID {printf("rule #22\n");}
        | T_ID '[' Expression ']';

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
      | T_NUM
			| Variable
			| Call
			| T_TRUE
			| T_FALSE
			| T_NOT Factor;

/* Rule #28 */
Call: T_ID '(' Args ')'
	{ printf("Rule #28: %s\n", $1); };

/* Rule #29 */
Args: Arg_List {printf("rule #29a\n");}
    | /* empty */;

/* Rule #30 */
Arg_List: Expression {printf("rule #30a\n");}
				| Expression ',' Arg_List {printf("rule #30b\n");}
				;


%%	/* end of rules, start of program */

/* Specify Return value*/
int main() { 
	yyparse();
}

