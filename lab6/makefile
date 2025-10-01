# Devon Sookhoo
# October 13th, 2025
# Lab 6 Abstract Syntax Tree


# Compiler Flags
CFLAGS = -g -O0 # turn off optimizations for debugging

all: lab6

# the yacc -d flag: generate the header file lab6.tab.h

lab6: lab6.y lab6.l ast.c ast.h
	clear
	yacc -dv lab6.y 
	lex lab6.l
	gcc $(CFLAGS) -o lab6 lex.yy.c y.tab.c ast.c

clean:
	rm -f lab6 y.tab.c y.tab.h
