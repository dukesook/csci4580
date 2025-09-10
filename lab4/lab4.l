  /*
    Devon Sookhoo
    September 1st, 2025
    Lab22
    Enhancements:
      - The regex rule for symbols was missing the parentheses.
      - Turned off debugging statement to reduce clutter in output.
  */



     /*            Small LEX routine which returns two formal tokens (INTEGER and VARIABLE)
                   along with single string elements like '+'.
 
                    This LEX definition is the companion to the docalc.y YACC routine which
                   is a simple calculator

                    Shaun Cooper
                    January 2015
     */


%{

/* Turned off debugging statement */
int mydebug=0;
int line_num=1;
#include "y.tab.h"
// [a-zA-Z][a-zA-Z0-9_]*
%}


%%

"int"    {if (mydebug) fprintf(stderr,"Type declaration found\n"); 
                       return(T_INT);}
[a-zA-Z][a-zA-Z0-9_]*		{if (mydebug) fprintf(stderr,"Letter found\n"); 
                       yylval.string=strdup(yytext); return(VARIABLE);}
[0-9][0-9]*	{if (mydebug) fprintf(stderr,"Digit found\n"); 
                       yylval.value=atoi((const char *)yytext); return(INTEGER);}
[ \t]		{if (mydebug) fprintf(stderr,"Whitespace found\n");}
[=\-+*/%&|();] 	{ if (mydebug) fprintf(stderr,"return a token %c\n",*yytext); 
                       return (*yytext);}
\n 		{ if (mydebug) fprintf(stderr,"cariage return %c\n",*yytext); 
                       line_num++;
                       return (*yytext);}

%%

int yywrap(void)
{ return 1;}


