# Devon Sookhoo
# October 31st, 2025
# Lab 7 Add Symbol Table and Type Checking
# Added symtable.c and symtable.h for symbol table management


# Compiler Flags
CFLAGS = -g -O0 # turn off optimizations for debugging

all: lab7

# the yacc -d flag: generate the header file lab7.tab.h

lab7: lab7.y lab7.l ast.c ast.h symtable.c symtable.h
	clear
	yacc -dv lab7.y 
	lex lab7.l
	gcc $(CFLAGS) -o lab7 lex.yy.c y.tab.c ast.c symtable.c

clean:
	rm -f lab7 y.tab.c y.tab.h y.output lex.yy.c
