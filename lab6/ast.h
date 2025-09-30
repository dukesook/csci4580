/*   Abstract syntax tree code


 Header file   
 Shaun Cooper January 2022

*/

#include<stdio.h>
#include<malloc.h>

#ifndef AST_H
#define AST_H
extern int mydebug;

/* define the enumerated types for the AST.  THis is used to tell us what 
sort of production rule we came across */

enum ASTtype {
   A_PROGRAM,
   A_VARDEC,
   A_FUNCTIONDEC,
   A_IDENT,
   A_NUMBER,
   A_EXPR,
   A_IFSTMT
 
	   //missing
};

enum DataTypes {
  A_INTTYPE,
   A_VOIDTYPE
};

enum OPERATORS {
   A_PLUS,
   A_MINUS,
   A_TIMES
 
	   //missing
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


ASTnode *program; // pointer to the tree

/*  Print out the abstract syntax tree */
void ASTprint(int level,ASTnode *p);

#endif // of AST_H
