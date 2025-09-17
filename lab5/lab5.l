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

int     { return T_INT;}
begin   { return T_BEGIN;}
end     { return T_END;}
void    { return T_VOID;}
boolean { return T_BOOLEAN;}
return  { return T_RETURN;}
write   { return T_WRITE;}
read    { return T_READ;}
"<="    { return T_LE;}
\".*\"  { yylval.string=strdup(yytext); return(T_STRING); }"

"int"    {if (mydebug) fprintf(stderr,"Type declaration found\n"); 
                       return(T_INT);}
void    { return T_VOID; }
[a-zA-Z][a-zA-Z0-9_]*		{if (mydebug) fprintf(stderr,"Letter found\n"); 
                       yylval.string=strdup(yytext); return(VARIABLE);}
[0-9][0-9]*	{if (mydebug) fprintf(stderr,"Digit found\n"); 
                       yylval.value=atoi((const char *)yytext); return(INTEGER);}
[ \t]		{if (mydebug) fprintf(stderr,"Whitespace found\n");}
[=\-+*/%&|();,[\]] 	{ if (mydebug) fprintf(stderr,"return a token %c\n",*yytext); 
                       return (*yytext);}
\n 		{ if (mydebug) fprintf(stderr,"cariage return %c\n",*yytext); 
                       line_num++;
                      //  return (*yytext); // don't return new line
                       }

%%

int yywrap(void)
{ return 1;}


