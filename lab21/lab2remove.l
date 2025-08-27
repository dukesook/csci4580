         /* simple lex program which removes comments from a source program
            The main key is that a variable "comment" is set when the start of a comment
            is seen and then unset when the ending set is seen.  It is possible to have
            two starts closed by on end.

            Shaun Cooper
            January 2015
 
         */

/* yytext - "is a global character pointer that always points to the current token that matched one of your regular expressions" */

/*********************************** Lex Section 1: Definitions ***********************************/
  int comment = 0;      /* 1 if in a comment, 0 if not */
  int debug = 0;        /* prints out debug statements if desired */
  int line_number = 1;  /* keep track of the line number for debugging */



/*********************************** Lex Section 2: Rules ***********************************/
%%
"/*"	{
/* Rule #1: Detect the begining of a comment */
	if (comment && debug) {
    fprintf(stderr, " >>>>>>>> line %d: Possible Nested comment <<<<<<<<<<\n", line_number);
  }
	comment = 1; /* You have entered a comment */
}

"*/"	{
/* Rule #2: Detect the end of a comment */
  if (!comment) {
    printf("%s",yytext); /*print out if it is not in a comment */
  }
            
  comment = 0;
}

\n		{
/* Rule #3: Detect new lines */
  line_number++; /* Increase the line count before proceeding to the next line */
  printf("\n"); /* Print a new line because.... */
}

.		{
/* Rule #4: Print out remaining characters */
  if (!comment) {
    printf("%s",yytext);
  }
}

%%


/*********************************** Lex Section 3: User Code ***********************************/
int yywrap(void)
{ return 1;
}

int main()
{
  yylex();
  
}

