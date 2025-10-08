/*
    Devon Sookhoo
    October 13th, 2025
    Lab 6 Abstract Syntax Tree
    Enhancements:
				- Resolved multiple definition errors by moving ASTnode *program to ast.c
            - Resolved multiple definition errors by adding extern to ASTnode *program in ast.h

*/

#include<stdio.h>
#include<malloc.h>

#ifndef AST_H
#define AST_H
extern int mydebug;

/* define the enumerated types for the AST.  This is used to tell us what 
sort of production rule we came across */

enum ASTtype {
   A_VARDEC,
   A_DEC_LIST,
   A_FUNCTIONDEC,
   A_FUNCTION_CALL, // Function Call Argument
   A_ARG_LIST, // The list of arguments in a function call
   A_Argument, // A single argument in a function call
   A_NUMBER,
   A_VARIABLE,
   A_EXPRESSION,
   A_IFSTMT,
   A_COMPOUND,
   A_STMT_LIST,
   A_WRITE,
   A_READ,
   A_PARAM, // Function Declaration Parameter
   A_VOID_PARAM, // Empty Parameter List
   A_ASSIGNMENT_STATEMENT, // Example: x = 5;
};

enum DataTypes {
  A_INTTYPE,
  A_VOIDTYPE,
  A_BOOLEANTYPE
};

enum OPERATORS {
   A_PLUS,
   A_MINUS,
   A_TIMES,
   A_LT,
   A_GT,
   A_LE,
   A_GE,
   A_EQ,
   A_NE,
   A_NOT,
};

/* define a type AST node which will hold pointers to AST structs that will
   allow us to represent the parsed code 
*/
typedef struct ASTnodetype
{
     enum ASTtype nodetype;
     enum OPERATORS operator;
     enum DataTypes datatype;
     char * name;
     int value;
     ///.. missing
     struct ASTnodetype *s1,*s2 ; /* used for holding IF and WHILE components -- not very descriptive */
} ASTnode;


/* uses malloc to create an ASTnode and passes back the heap address of the newley created node */
ASTnode *ASTCreateNode(enum ASTtype mytype);

void PT(int howmany);

// declared as extern to resolve multiple definition errors
extern ASTnode *program; // pointer to the tree

/*  Print out the abstract syntax tree */
void ASTprint(int level,ASTnode *p);

const char* operator_to_string(enum OPERATORS op);

#endif // of AST_H
