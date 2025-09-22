/*
    Devon Sookhoo
    September 22nd, 2025
    Lab 5 ALGO-C
    Enhancements:
				1. Caught error in rule #3, #4, & #11 var-declaration(s)
				2. Added Function Prototypes
				3. Print every T_ID
				4. Print every string for write
				5. Made additive_expression, simple_expression and term LEFT RECURSIVE
				6. Update yyerror() such that it prints the error along with the global line number;
				7. All tokens coming from LEX shall be upper case and start with "T_" 
				8. Added Continue and Break statements
				9. All non-terminals will be Camel Case
				10. Added comments to every rule and major code block for clarity
				11. Added symtable.c and symtable.h with basic functions to manage a symbol
				12. Added helper functions to log strings, tokens, identifiers, and numbers
*/

%{



/* begin specs */
#include <stdio.h>
#include <ctype.h>
#include "symtable.h"

#define MAX_VARIABLES 4 // max number of variables
#define ERROR -1 // error code

/* declare function prototype to resolve warning */
int yylex(void); // prototype for the lexing function
int regs[MAX_VARIABLES]; // values[address] = value
int variable_count = 0; // how variables many are defined
extern int line_num; // the current line number
int debugsw=0; // debug switch

// Helper Function to log strings
void log_string(char* rule, char* t_string) {
	printf("Rule %s: \t line: %d \t T_STRING: %s\n", rule, line_num, t_string);
}

// Helper Function to log tokens
void log_token(char* rule, char* type, char* token) {
	printf("Rule %s: \t line: %d \t %s: %s\n", rule, line_num, type, token);
}

// Helper Function to log identifiers
void log_id(char* rule_number, char* t_id) {
	// printf("Rule %s: \t line: %d \t T_ID: %s\n", rule_number, line_num, t_id);
	// printf("calling log_token:\n");
	log_token(rule_number, "T_ID", t_id);
}

// Helper Function to log numbers
void log_t_num(char* rule_number, int t_num) {
	printf("Rule %s: \t line: %d \t T_NUM: %d\n", rule_number, line_num, t_num);
}

// Error Handling Function
void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  printf ("%s on line number %d\n", s, line_num);
}


%}

/*  defines the start symbol, what values come back from LEX and how the operators are associated  */
%start Program

// Define the union for YYSTYPE
// The union must cover all possible types of values that can be returned by the tokens and non-terminals.
%union
{
	int value; // for T_NUM
	char* string; // for T_ID and T_STRING
}

/* The Expected Tokens From Lex */
%token <value> T_NUM // integer number
%token <string> T_ID T_STRING // identifier and string
%token T_INT T_VOID T_BOOLEAN
%token T_WRITE T_READ T_RETURN
%token T_TRUE T_FALSE T_NOT T_AND T_OR
%token T_GE T_LE T_NE T_EQ T_LT T_GT
%token T_BEGIN T_END T_IF T_THEN T_ENDIF T_WHILE T_DO T_ELSE
%token T_CONTINUE T_BREAK

%left '|'					/* lowest precedence */
%left '&'
%left '+' '-'
%left '*' '/' '%'
//%left UMINUS			/* highest precedence */


%%	/* end specs, begin rules */

/* Rule #1 */
Program: Declaration_List
			{ printf("============= Successful Parse! =============\n"); };

/* Rule #2 */
Declaration_List: Declaration
								| Declaration_List Declaration;

/* Rule #3 */
Declaration: Var_Declaration
					 | Func_Declaration
					 | Func_Prototype;


/* Rule #4 */
Var_Declaration: Type_Specifier Var_List ';';

/* Rule 4a */
Var_List: T_ID 															{ log_id("4a", $1); }
        | T_ID '[' T_NUM ']'								{ log_id("4a", $1); }
				| T_ID ',' Var_List									{ log_id("4a", $1); }
				| T_ID '[' T_NUM ']' ',' Var_List		{ log_id("4a", $1); };

/* Rule #5 */
Type_Specifier: T_INT
							| T_VOID
							| T_BOOLEAN;

/* Rule #6 */
Func_Declaration: Type_Specifier T_ID '(' Params ')' Compound_Stmt
	{ log_id("6", $2); };

/* Rule #7 */
Params: T_VOID
      | Param_List;

/* Rule #8 */
Param_List: Param
				  | Param ',' Param_List;

/* Rule #9 */
Param: Type_Specifier T_ID 						{ log_id("9", $2); }
			| Type_Specifier T_ID '[' ']' 	{ log_id("9", $2); };

/* Rule #10 */
Compound_Stmt: T_BEGIN  Local_Declarations  Statement_List  T_END;

/* Rule #11 */
Local_Declarations: Var_Declaration Local_Declarations
                  |  /* empty */;

/* Rule #12 */
Statement_List: Statement Statement_List
              | /* empty */;

/* Rule #13 */
Statement: Expression_Stmt
				 | Compound_Stmt		
				 | Selection_Stmt
				 | Iteration_Stmt
				 | Assignment_Stmt
				 | Return_Stmt
         | Write_Stmt
         | Read_Stmt
				 | Continue_Stmt
				 | Break_Stmt;

/* Rule #14 */
Expression_Stmt: Expression ';'
 							 | ';';

/* Rule #15 */
Selection_Stmt: T_IF Expression T_THEN Statement T_ENDIF
              | T_IF Expression T_THEN Statement T_ELSE Statement T_ENDIF;

/* Rule #16 */
Iteration_Stmt: T_WHILE Expression T_DO Statement;

/* Rule #17 */
Return_Stmt: T_RETURN ';'
					 | T_RETURN Expression ';';

/* Rule #18 */
Read_Stmt: T_READ Variable ';';

/* Rule #19 */
Write_Stmt: T_WRITE Expression ';'
					| T_WRITE T_STRING ';' { log_string("19", $2); };

/* Rule #20 */
Assignment_Stmt: Variable '=' Simple_Expression ';';

/* Rule #21 */
Expression: Simple_Expression;

/* Rule #22 */
Variable: T_ID 										  { log_id("22", $1);}
        | T_ID '[' Expression ']' 	{ log_id("22", $1);}

/* Rule #23 */
Simple_Expression: Additive_Expression
                 | Simple_Expression Relop Additive_Expression;

/* Rule #22 */
Relop: T_LE
     | T_LT
		 | T_GT
		 | T_GE
		 | T_EQ
		 | T_NE;

/* Rule #23 */
Additive_Expression: Term
                   | Additive_Expression Add_Op Term;

/* Rule #24 */
Add_Op: '+'
		  | '-';

/* Rule #25 */
Term: Factor
		| Term Mult_Op Factor;

/* Rule #26 */
Mult_Op: '*'
		   | '/'
		   | T_AND
		   | T_OR;

/* Rule #27 */
Factor: '(' Expression ')'
      | T_NUM  { log_t_num("27", $1); }
			| Variable
			| Call
			| T_TRUE 	{ log_token("27", "T_TRUE", "true"); }
			| T_FALSE { log_token("27", "T_FALSE", "false"); }
			| T_NOT Factor;

/* Rule #28 */
Call: T_ID '(' Args ')' 
			{ log_id("28", $1); };

/* Rule #29 */
Args: Arg_List
    | /* empty */;

/* Rule #30 */
Arg_List: Expression
				| Expression ',' Arg_List;

/* Graduate Student Required Rule */
Func_Prototype: Type_Specifier T_ID '(' Params ')' ';' {log_id("Func_Prototype", $2);};

/* Graduate Student Required Rule */
Continue_Stmt: T_CONTINUE ';' { log_token("Continue_Stmt", "T_CONTINUE", "continue"); } ;

/* Graduate Student Required Rule */
Break_Stmt: T_BREAK ';' { log_token("Break_Stmt", "T_BREAK", "break"); } ;

%%	/* end of rules, start of program */

/* The main function which calls yyparse() */
int main() { 
	yyparse();
}

