/*   Abstract syntax tree code

     This code is used to define an AST node, 
    routine for printing out the AST
    defining an enumerated nodetype so we can figure out what we need to
    do with this.  The ENUM is basically going to be every non-terminal
    and terminal in our language.

    Shaun Cooper February 2023

*/

#include<stdio.h>
#include<malloc.h>
#include "ast.h" 


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

// PRE: ???
//  POST:   ???
void PT(int howmany)
{
	 // MISSING
}

// PRE:  a Data Type
// POST:  a character string for that type to print nicely -- caller does final output

char * DataTypeToString(enum DataTypes mydatatype){
    switch (mydatatype) {
           case A_VOIDTYPE:  return ("void");
                             break;
           default: printf("Unknown type in DataTypeToString\n");
                     exit(1);
      } //of switch
}// of DataTypeToString()


/*  Print out the abstract syntax tree */
void ASTprint(int level,ASTnode *p)
{
   int i;
   if (p == NULL ) return;

    // when here p is not NULL
   switch (p->nodetype) {
        case A_VARDEC :  printf("Variable ");
                         printf("%s ", DataTypeToString(p->datatype));
                         printf(" %s",p->name);
                         if (p->value > 0)
                            printf("[%d]",p->value);
                         printf("\n");
		         ASTprint(level,p->s1); 
                     break;

        default: printf("unknown type in ASTprint\n");
                 printf("Exiting ASTprint immediately\n");
                 exit(1);


       } // of switch
} // of ASTprint



/* dummy main program so I can compile for syntax error independently   
main()
{
}
/* */
