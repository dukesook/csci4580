# Devon Sookhoo
# September 1st, 2025
# lab21
# Enhancments: Generates the lab21 executable from the lab2remove.l file.


# Default Target
all: lab21

# Primary Target: lab21
# list of prerequisite files, tokenize with lex, and compile with gcc
lab21: lab2remove.l
	lex lab2remove.l
	gcc lex.yy.c -o lab21

# Clean Target
clean: 
	rm -f lab21 lex.yy.c