# Devon Sookhoo
# September 1st, 2025
# lab22
# This makefile compiles and links the lex and yacc files for lab22.


# Default Target
all: lab22

# Primary Target: lab22
lab22: lab2docalc.l lab2docalc.y
	lex lab2docalc.l
	yacc -d lab2docalc.y
	gcc y.tab.c lex.yy.c -o lab22

# Clean Target
clean: 
	rm lab22 lex.yy.c y.tab.c y.tab.h



# In the makefile   explain how  the following calculator instructions work in DETAIL for the two sentences in the calculator
# "a = 3 + 5"
# "a"

# First, lex will tokens input into: [ a, =, 3, +, 5 ] & [ a ], then hand this off to YACC.
# YACC will take the tokens provided by lex and parse them according to the context-free grammar.
# Using the expr = INTERGER rule, it will identify 3 and  as integers.
# using the expr + expr rule, it will identify 3 + 5 as an expression and reduce it to 8.
# using the VARIABLE = expr rule, it will identify a = 8 as a statement and assign the value 8 to the variable a.
# using the list = list stat rule, it will add the statement to the list of statements.
