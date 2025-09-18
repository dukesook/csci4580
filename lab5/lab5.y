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
%token T_BEGIN T_END


%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
//%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */


Program: Declaration_List;

Declaration_List: Declaration
								| Declaration_List Declaration; /* WARNING */

Declaration: Var_Declaration
					 | Func_Declaration;

Var_Declaration: Type_Specifier Var_List ';';

Type_Specifier: T_INT
							| T_VOID
							| T_BOOLEAN;

Var_List: T_ID
						{printf("found ID in Var_List -> T_ID %s %d\n", $1, line_num);}
        | T_ID '[' T_NUM ']'
				| T_ID ',' Var_List
						{printf("found ID in Var_List -> T_ID %s %d\n", $1, line_num);}
				| T_ID '[' T_NUM ']' ',' Var_List;

Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt;

Params: T_VOID
      | Param_List;

Param_List: Param
				  | Param ',' Param_List;

Param: Type_Specifier T_ID
			| Type_Specifier T_ID '[' ']';

Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END

Local_Declarations: Var_Declaration Local_Declarations
                  |  /* empty */;

Statement_List: Statement Statement_List
              | /* empty */;

Statement: Write_Stmt
         | Read_Stmt;


Write_Stmt: T_WRITE T_STRING ';'
			        { printf("found a string in WRITE with value %s on line %d\n", $2, line_num); }

Read_Stmt: T_READ Variable ';';

Variable: T_ID
        | T_ID '[' Expr ']';

Expr: Simple_Expression;

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

Factor: '(' Expr ')'
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