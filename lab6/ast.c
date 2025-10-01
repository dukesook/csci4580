/*
    Devon Sookhoo
    October 13th, 2025
    Lab 6 Abstract Syntax Tree
    Enhancements:
				- Moved ASTnode *program to ast.c to avoid multiple definition errors

*/

#include<stdio.h>
#include<malloc.h>
#include<stdlib.h>
#include "ast.h" 


ASTnode *program; // pointer to the tree

/* uses malloc to create an ASTnode and passes back the heap address of the newley created node */
// PRE: ???
// POST:   
ASTnode *ASTCreateNode(enum ASTtype mytype)
{
    ASTnode *p;
    if (mydebug) fprintf(stderr,"Creating AST Node \n");
    p=(ASTnode *)malloc(sizeof(ASTnode));
    p->nodetype=mytype;
    p->s1=NULL;
    p->s2=NULL;
    p->value=0;
    return(p);
}

/*  Helper function to print tabbing */

// PRE: Given a positive integer
// POST:   Print that number of tabs
void PT(int howmany)
{
    for (int i = 0; i < howmany; i++) {
        printf(" ");
    }
}

// PRE:  a Data Type
// POST:  a character string for that type to print nicely -- caller does final output

char * DataTypeToString(enum DataTypes mydatatype){
    switch (mydatatype) {
           case A_VOIDTYPE:
                return ("void");
            case A_INTTYPE:
                return ("int");
            case A_BOOLEANTYPE:
                return ("boolean");
           default: printf("Unknown type in DataTypeToString\n");
                     exit(1);
      } //of switch
}// of DataTypeToString()


/*  Print out the abstract syntax tree */
// PRE: Pointer to an AST Tree
// POST: Print formatted tree output
void ASTprint(int level,ASTnode *p)
{
   int i;
   if (p == NULL ) return;

    // when here p is not NULL
   switch (p->nodetype) {
        case A_DEC_LIST:  ASTprint(level, p->s1);
                          ASTprint(level, p->s2);
                          break;
        case A_VARDEC:  printf("Variable ");
                         printf("%s ", DataTypeToString(p->datatype));
                         printf(" %s",p->name);
                         if (p->value > 0)
                            printf("[%d]",p->value);
                         printf("\n");
		         ASTprint(level,p->s1); 
                     break;

        default: printf("unknown type in ASTprint %d\n", p->nodetype);
                 printf("Exiting ASTprint immediately\n");
                 exit(1);


       } // of switch
} // of ASTprint



/* dummy main program so I can compile for syntax error independently   
main()
{
}
/* */
