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
			6. Fixed Typo: answer
			7. Use debugsw variable to toggle debug statements instead of always printing them.
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
#include "symtable.h"

/* declare function prototype to resolve warning */
int yylex(void);

int regs[4]; // values[address] = value
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
%token <string> VARIABLE
%token T_INT

%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */

/* For each rule, precedence is determined by the last token */

P : DECLS list
	;

DECLS : DECLS DECL 
			| /* empty */
			;

DECL : T_INT VARIABLE ';' '\n'
		{
			// Try to declare a variable
			bool found = Search($2);
			if (found) {
				printf("The variable exists\n");
			} else {
				printf("The varible does NOT exist\n");
				printf("Adding %s to the symbol table\n", $2);
				Insert($2, 0);
			}
			// TODO: Check if variable ($2) is already defined.
			// TODO: if not, check to make sure our symtable has enough room
			// TODO: you should use a global varible that defines the size of the our memory, reg
			// TODO: you will have to maintain a global varible that tells you now many are defined
			// TODO: if not there, and there is room, then add the symbol table and "allocate" it a slot in regs.
			// TODO: increment the "oneup"?
		}
		 ;



list	:	/* empty */
	|	list stat '\n'
	|	list error '\n'
			{ yyerrok; }
	;

stat	:	expr
			/* Added appropriate whitespace */
			/* Fixed Typo: answer*/
			{ fprintf(stderr,"the answer is %d \n", $1); }
	|	VARIABLE '=' expr
			{ // TODO: make sure that $1 has bee defined
				// TODO: YACC musk fail if $1 is not defined, not LEX
				regs[FetchAddress($1)] = $3; }
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
	
	|	VARIABLE { 
				// TODO: Make sure that $1 has been defined. (else, throw an error);
				$$ = regs[FetchAddress($1)]; 
				/* Using debugsw variable to toggle debug statements*/
				if (debugsw) 
					fprintf(stderr,"found a variable value = %s\n",$1); /* Added whitespace to improve readability*/
			}
	
	|	INTEGER {
		$$=$1;
			/* Using debugsw variable to toggle debug statements*/
			if (debugsw)
				fprintf(stderr,"found an integer\n");
		}

	/* | T_INT {
		$$=$1;
		if (debugsw)
				fprintf(stderr,"found a type declaration\n");
	} */
	;

/* $1 gets the value of yylval */


%%	/* end of rules, start of program */

/* Specify Return value*/
int main()
{ yyparse();
}
