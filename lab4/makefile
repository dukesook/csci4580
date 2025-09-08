# Devon Sookhoo
# September 19th, 2025
# Lab 4 Symbol Table with YACC


# Compiler Flags
CFLAGS = -g -O0 # turn off optimizations for debugging

all: lab4

# the yacc -d flag: generate the header file lab4.tab.h

lab4: symtable.c symtable.h
	yacc -d lab4.y 
	lex lab4.l
	gcc $(CFLAGS) -o lab4 lex.yy.c y.tab.c symtable.c

clean:
	rm -f lab3
