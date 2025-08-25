     /*  This lex routine uses a counting array to match alphabeticstrings 
         and make a frequency count.
  
         The real item to notice is that yywrap() is called at EOF and then is run
         to do what we need to do.   yywrap() returns true when we have a successful 
         end to the program.  We may want to return false (0) if we want to lexing process 
         to fail 

        Shaun Cooper
        January 2015
   */


   /*
     Header Comments
     Devon Sookhoo
     August 25th, 2025
     Lab 1
     Enhancements Made: Added a counter for numbers.
   */

     /*  
     Lex files are divided into three sections, separated by %%:

     Definitions
     %%
     Rules
     %%
     User Code
    */

/* Definitions */

	int lgths[100];
     int number_count;

/* Rules */
/* Counts the numbers of words with n length */
/* Counts the number of numbers*/

%%
[a-zA-Z]+	lgths[yyleng]++;
[0-9]+	number_count++;
.	|
\n	;
%%

/* User Code */

// yywrap() is called automatically when the scanner reaches EOF.
int yywrap()
{
	int i;

     // Print the number count.
     printf("Number of numbers: %d\n", number_count);
	
     // Prints the header for the output table.
     printf("Length  No. words\n");
     
     // Loops through lgths[] and print the lengths and their counts.
	for (i=1; i<100; i++) {
          // ignore lengths with zero counts.
		if (lgths[i] > 0) {
			printf("%5d%10d\n",i,lgths[i]);
		}
	} // end for loop
	return(1);
} // end yywrap

// This is the main function, which serves as the entry point to the program.
// It calls yylex() to start the lexical analysis process.
int main()
{  yylex();

} // end main
