# Devon Sookhoo
# September 22nd, 2025
# Lab 5 ALGO-C


# Compiler Flags
CFLAGS = -g -O0 # turn off optimizations for debugging

all: lab5

# the yacc -d flag: generate the header file lab5.tab.h

lab5: lab5.y lab5.l symtable.c symtable.h
	yacc -d lab5.y 
	lex lab5.l
	gcc $(CFLAGS) -o lab5 lex.yy.c y.tab.c symtable.c

clean:
	rm -f lab5 y.tab.c y.tab.h
	rm -rf tests_output/
