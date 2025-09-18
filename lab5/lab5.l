  /*
    Devon Sookhoo
    September 2nd, 2025
    Lab 5 ALGO-C
    Enhancements:
      - 
      - 
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
\".*\"  { yylval.string=strdup(yytext); return(T_STRING); }

[a-zA-Z][a-zA-Z0-9_]*		{if (mydebug) fprintf(stderr,"Letter found\n"); 
                       yylval.string=strdup(yytext); return(T_ID);}
[0-9][0-9]*	{if (mydebug) fprintf(stderr,"Digit found\n"); 
                       yylval.value=atoi((const char *)yytext); return(T_NUM);}
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


