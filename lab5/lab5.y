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

/* defines the expected tokens from Lex*/
%token <value> T_NUM
%token <string> T_ID
%token T_INT T_VOID T_BOOLEAN
%token T_WRITE T_READ T_RETURN T_GE T_LE
%token T_BEGIN T_END
%token T_STRING

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
        | T_ID '[' T_NUM ']'
				| T_ID ',' Var_List
				| T_ID '[' T_NUM ']' ',' Var_List;

Func_Declaration: FOOBAR
                ;

FOOBAR: T_BEGIN T_END T_STRING T_WRITE T_READ T_RETURN T_GE T_LE;


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