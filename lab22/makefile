# Devon Sookhoo
# September 1st, 2025
# lab22
# Enhancments: ???????


# Default Target
all: lab22

# Primary Target: lab22
# list of prerequisite files, tokenize with lex, and compile with gcc
lab22: lab2docalc.l lab2docalc.y
	yacc -d lab2docalc.y
	lex lab2docalc.l
	gcc y.tab.c lex.yy.c -o lab22

# Clean Target
clean: 
	rm lab22 lex.yy.c y.tab.c y.tab.h