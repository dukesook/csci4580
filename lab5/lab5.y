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

%start P

%union
{
	int value;
	char* string;
}

/* defines the expected tokens from Lex*/
%type <value> expr
%token <value> INTEGER
%token <string> VARIABLE T_STRING
%token T_INT T_BEGIN T_END T_VOID

%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */

/* For each rule, precedence is determined by the last token */

Program : DECLS list
	;




/* $1 gets the value of yylval */


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