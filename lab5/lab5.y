/*
    Devon Sookhoo
    September 2nd, 2025
    Lab 5 ALGO-C
    Enhancements:
				1. 
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
								| Declaration_List Declaration; /* WARNING */

/* Rule #3 */
Declaration: Var_Declaration
					 | Func_Declaration;

/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';';

/* Rule 4a */
Var_List: T_ID
						{printf("found ID in Var_List -> T_ID %s %d\n", $1, line_num);}
        | T_ID '[' T_NUM ']'
				| T_ID ',' Var_List
						{printf("found ID in Var_List -> T_ID %s %d\n", $1, line_num);}
				| T_ID '[' T_NUM ']' ',' Var_List;

/* Rule #5 */
Type_Specifier: T_INT
							| T_VOID
							| T_BOOLEAN;

/* Rule #6 */
Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt;

/* Rule #7 */
Params: T_VOID
      | Param_List;

/* Rule #8 */
Param_List: Param
				  | Param ',' Param_List;

/* Rule #9 */
Param: Type_Specifier T_ID
			| Type_Specifier T_ID '[' ']';

/* Rule #10 */
Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations
                  |  /* empty */;

/* Rule #12 */
Statement_List: Statement Statement_List
              | /* empty */;

/* Rule #13 */
/* TODO add more statements! */
Statement: Expression_Stmt
				 /* | Compound_Stmt */
				 | Selection_Stmt
				 | Iteration_Stmt
				 /* | Assignment_Stmt */
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
Iteration_Stmt: T_WHILE Expression T_DO Statement

/* Rule #17 */
Return_Stmt: T_RETURN ';'
					 | T_RETURN Expression ';';

/* Rule #18 */
Read_Stmt: T_READ Variable ';';

/* Rule #19 */
Write_Stmt: T_WRITE Expression ';'
					| T_WRITE T_STRING ';'
			        { printf("found a string in WRITE with value %s on line %d\n", $2, line_num); }

/* Rule #20 */

/* Rule #21 */

/* Rule #22 */
Variable: T_ID
        | T_ID '[' Expression ']';

Expression: Simple_Expression;

Simple_Expression: Additive_Expression
                 | Additive_Expression Relop Additive_Expression;

Relop: T_LE
     | T_LT
		 | T_GT
		 | T_GE
		 | T_EQ
		 | T_NE;

Additive_Expression:  Additive_Expression Add_Op Term
									 | Term;

Add_Op: '+'
		 | '-';

Term: Term Multop Factor
		| Factor;

Multop: '*'
		 | '/'
		 | T_AND
		 | T_OR;

Factor: '(' Expression ')'
      | T_NUM
			| Variable
			/* | TODO call */
			| T_TRUE
			| T_FALSE
			| T_NOT Factor;




%%	/* end of rules, start of program */

/* Specify Return value*/
int main()
{ yyparse();
}


/*

example input:
int foo;
int bar;


*/