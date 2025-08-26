
all: lab2

lab2: lab2remove.l
	lex lab2remove.l
	gcc lex.yy.c -o lab21

clean: 
	rm -f lab21, lex.yy.c