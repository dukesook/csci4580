# Devon Sookhoo
# October 31st, 2025
# Lab 7 Add Symbol Table and Type Checking
# Added symtable.c and symtable.h for symbol table management


# Compiler Flags
CFLAGS = -g -O0 # turn off optimizations for debugging

all: lab9

# the yacc -d flag: generate the header file lab9.tab.h

lab9: lab9.y lab9.l ast.c ast.h symtable.c symtable.h
	clear
	yacc -dv lab9.y 
	lex lab9.l
	gcc $(CFLAGS) -o lab9 lex.yy.c y.tab.c ast.c symtable.c

clean:
	rm -f lab9 y.tab.c y.tab.h y.output lex.yy.c
