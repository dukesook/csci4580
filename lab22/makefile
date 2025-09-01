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