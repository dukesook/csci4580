/*
    Devon Sookhoo
    September 1st, 2025
    Lab22
    Enhancements:
			1. Fixed unary minus by removing extra expr symbol.
			2. Added whitespace to final answer.
			3. Added multiplcation operator.
			4. Specified int as the return value for main().
			5. Declared the function prototype for yylex() to resolve warning.
*/

%{

/*
 *			**** CALC ****
 *
 * This routine will function like a desk calculator
 * There are 26 integer registers, named 'a' thru 'z'
 *
 */

/* This calculator depends on a LEX description which outputs either VARIABLE or INTEGER.
   The return type via yylval is integer 

   When we need to make yylval more complicated, we need to define a pointer type for yylval 
   and to instruct YACC to use a new type so that we can pass back better values
 
   The registers are based on 0, so we substract 'a' from each single letter we get.

   based on context, we have YACC do the correct memmory look up or the storage depending
   on position

   Shaun Cooper
    January 2015

   problems  fix unary minus, fix parenthesis, add multiplication
   problems  make it so that verbose is on and off with an input argument instead of compiled in
*/


	/* begin specs */
#include <stdio.h>
#include <ctype.h>

/* declare function prototype to resolve warning */
int yylex(void);

int regs[26];
int base, debugsw;

void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  printf ("%s\n", s);
}


%}
/*  defines the start symbol, what values come back from LEX and how the operators are associated  */

%start list

/* defines the expected tokens from Lex*/
%token INTEGER
%token  VARIABLE

%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */

/* For each rule, precedence is determined by the last token */

list	:	/* empty */
	|	list stat '\n'
	|	list error '\n'
			{ yyerrok; }
	;

stat	:	expr
			/* Added appropriate whitespace */
			{ fprintf(stderr,"the answer is %d \n", $1); }
	|	VARIABLE '=' expr
			{ regs[$1] = $3; }
	;

expr	:	'(' expr ')'
			{ $$ = $2; }
	|	expr '-' expr
			{ $$ = $1 - $3; }
	|	expr '+' expr
			{ $$ = $1 + $3; }
	/* Added multiplication */
	|	expr '*' expr
			{ $$ = $1 * $3; }
	|	expr '/' expr
			{ $$ = $1 / $3; }
	|	expr '%' expr
			{ $$ = $1 % $3; }
	|	expr '&' expr
			{ $$ = $1 & $3; }
	|	expr '|' expr
			{ $$ = $1 | $3; }
	/* Fixed unary minus by removing extra expr symbol */
	|	'-' expr	%prec UMINUS
			{ $$ = -$2; }
	|	VARIABLE
	/* Added whitespace to improve readability*/
			{ $$ = regs[$1]; fprintf(stderr,"found a variable value = %d\n",$1); }
	|	INTEGER {$$=$1; fprintf(stderr,"found an integer\n");}
	;

/* $1 gets the value of yylval */


%%	/* end of rules, start of program */

/* Specify Return value*/
int main()
{ yyparse();
}
