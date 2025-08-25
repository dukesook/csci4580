# Every file shall have a comment
# Runs:
#		$ lex lab1.l
#   $ gcc lex.yy.c -o lab1
# lab1.l -> lex.yy.c -> lab1
# Devon Sookhoo
# August 20, 2025

# Makefile for lab1:
# This makefile defines 3 labels: all, lab1, and clean.

# The all label is the default label. It simply calls lab1.
all: 	lab1

# The lab1 label depends on lab1.l.
# It the runs lex on lab1.l to produce lex.yy.c.
# It then calls gcc to compile lex.yy.c into the lab1 executable.
lab1:	lab1.l
			lex lab1.l
			gcc lex.yy.c -o lab1

# The clean label removes the lab1 executable.
clean:
			rm -f lab1
