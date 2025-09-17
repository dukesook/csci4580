/*
    Devon Sookhoo
    September 19th, 2025
    Lab4
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



/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include "symtable.h"

// Use to manage the size of the symbol table
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
			
			// Assert variable doesn't exist
			bool found = Search($2);
			if (found) {
				printf("Error! You can't declare a variable that already exists!\n");
				return ERROR;
			}

			// Assert room in symbol table
			if (variable_count >= MAX_VARIABLES) {
				printf("Error! No more room in the symbol table!\n");
				return ERROR;
			}
			Insert($2, variable_count); // use variable_count as the address
			variable_count++; // increment the count of defined variables
			
			printf("Added variable: %s\n", $2);
			printf("\tThere are now %d variables defined\n", variable_count);
			// printf("\tMax number of variables is %d\n", MAX_VARIABLES);

			// Display();
		}
		 ;



list	:	/* empty */
	|	list stat '\n'
	|	list error '\n'
			{ yyerrok; }
	;

stat	:	expr
			/* Added appropriate whitespace */
			/* Fixed Typo: answer */
			{ fprintf(stderr,"the answer is %d \n", $1); }
	|	VARIABLE '=' expr
			{
				// make sure that VARIABLE has bee defined
				bool found = Search($1);
				if (!found) {
					// YACC musk fail if VARIABLE is not defined, not LEX
					printf("Error! You can't assign a value to an undefined variable!\n");
					return ERROR;
				}
				/* assign value to variable */
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
				// TMake sure that $1 has been defined. (else, throw an error);
				bool found = Search($1);
				if (!found) {
					// YACC musk fail if VARIABLE is not defined, not LEX
					printf("Error! You can't use an undefined variable!\n");
					return ERROR;
				}
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


/*

example input:
int foo;
int bar;


*/