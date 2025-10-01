  /*
    Devon Sookhoo
    October 13th, 2025
    Lab 6 Abstract Syntax Tree
    Enhancements:
      - Removed comments from previous labs
      - #include "ast.h"
  */


%{

/* Turned off debugging statement */
int mydebug=0; // set to 1 to see debug info
int line_num=1; // line number for error reporting
#include "ast.h" // include the AST header file
#include "y.tab.h" // for token defines

// Debug function to reduce clutter
void debug() {
  if (mydebug) {
    fprintf(stderr, "Lex: %s\n", yytext); 
  }
}

%}


%%

int      { debug(); return T_INT;}
begin    { debug(); return T_BEGIN;}
end      { debug(); return T_END;}
void     { debug(); return T_VOID;}
boolean  { debug(); return T_BOOLEAN;}
return   { debug(); return T_RETURN;}
read     { debug(); return T_READ;}
write    { debug(); return T_WRITE;}
not      { debug(); return T_NOT;}
true     { debug(); return T_TRUE;}
false    { debug(); return T_FALSE;}
if       { debug(); return T_IF;}
then     { debug(); return T_THEN;}
endif    { debug(); return T_ENDIF;}
while    { debug(); return T_WHILE;}
do       { debug(); return T_DO;}
else     { debug(); return T_ELSE;}
and      { debug(); return T_AND;}
or       { debug(); return T_OR;}
continue { debug(); return T_CONTINUE;}
break    { debug(); return T_BREAK;}
"<="     { debug(); return T_LE;}
"<"      { debug(); return T_LT;}
">="     { debug(); return T_GE;}
">"      { debug(); return T_GT;}
"=="     { debug(); return T_EQ;}
"!="     { debug(); return T_NE;}
\/\/.*   { debug(); /*comment found */ }
\".*\"   { debug(); yylval.string=strdup(yytext); return(T_STRING); }

[a-zA-Z][a-zA-Z0-9_]* {
  debug();
  yylval.string=strdup(yytext);
  return(T_ID);
}

[0-9][0-9]* {
  debug();
  yylval.value=atoi((const char *)yytext);
  return(T_NUM);
}

[ \t] {
  if (mydebug) {
    // fprintf(stderr, "Whitespace found\n");
  }
}

[=\-+*/%&|();,[\]] 	{
  debug();
  return (*yytext);
}

\n  {
  if (mydebug) {
    // fprintf(stderr, "New Line return %c\n",*yytext); 
  }
  line_num++;
  //  return (*yytext); // don't return new line
}

%%

int yywrap(void)
{ return 1;}


