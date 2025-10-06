/*
    Devon Sookhoo
    October 13th, 2025
    Lab 6 Abstract Syntax Tree
    Enhancements:
                                - Moved ASTnode *program to ast.c to avoid
   multiple definition errors

*/

#include "ast.h"
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>

ASTnode *program; // pointer to the tree

/* uses malloc to create an ASTnode and passes back the heap address of the
 * newley created node */
// PRE: ???
// POST:
ASTnode *ASTCreateNode(enum ASTtype mytype) {
  ASTnode *p;
  if (mydebug)
    fprintf(stderr, "Creating AST Node \n");
  p = (ASTnode *)malloc(sizeof(ASTnode));
  p->nodetype = mytype;
  p->s1 = NULL;
  p->s2 = NULL;
  p->value = 0;
  return (p);
}

/*  Helper function to print tabbing */

// PRE: Given a positive integer
// POST:   Print that number of tabs
void PT(int howmany) {
  for (int i = 0; i < howmany; i++) {
    printf(" ");
  }
}

// PRE:  a Data Type
// POST:  a character string for that type to print nicely -- caller does final
// output

char *DataTypeToString(enum DataTypes mydatatype) {
  switch (mydatatype) {
  case A_VOIDTYPE:
    return ("VOID");
  case A_INTTYPE:
    return ("int");
  case A_BOOLEANTYPE:
    return ("boolean");
  default:
    printf("Unknown type in DataTypeToString\n");
    exit(1);
  } // of switch
} // of DataTypeToString()

/*  Print out the abstract syntax tree */
// PRE: Pointer to an AST Tree
// POST: Print formatted tree output
void ASTprint(int level, ASTnode *p) {
  int i;
  if (p == NULL)
    return;

  // when here p is not NULL
  switch (p->nodetype) {
    case A_DEC_LIST:
    PT(level);
    ASTprint(level, p->s1);
    ASTprint(level, p->s2);
    break;
    case A_VARDEC:
    PT(level);
    printf("Variable ");
    printf("%s ", DataTypeToString(p->datatype));
    printf(" %s", p->name);
    if (p->value > 0)
      printf("[%d]", p->value);
    printf("\n");
    ASTprint(level, p->s1);
    break;
  case A_FUNCTIONDEC:
    PT(level);
    printf("Function ");
    printf("%s ", DataTypeToString(p->datatype)); // return type
    printf("%s", p->name); // function name
    printf("(");
    ASTprint(level+1, p->s1); // parameters
    printf(")");
    printf("\n");
    ASTprint(level+1, p->s2); // compound
    break;
  case A_NUMBER:
    PT(level);
    printf("Number: %d\n", p->value);
    break;
  case A_EXPR:
    PT(level);
    const char* operator = operator_to_string(p->operator);
    printf("%s ", DataTypeToString(p->datatype));
    printf("Expression Operator: %s\n", operator);
    ASTprint(level+1, p->s1);
    ASTprint(level+1, p->s2);
    break;
  case A_IFSTMT:
    PT(level);
    printf("ASTprint(): todo! case: A_IFSTMT \n");
    break;
  case A_COMPOUND:
    PT(level);
    printf("BEGIN\n");
    ASTprint(level+1, p->s1); // Local Declarations
    ASTprint(level+1, p->s2); // Statement List
    PT(level);
    printf("END\n");
    break;
  case A_STMT_LIST:
    PT(level);
    ASTprint(level, p->s1); // Statement
    ASTprint(level, p->s2); // Statement List
    break;
  case A_WRITE:
    PT(level);
    printf("WRITE\n");
    PT(level+1);
    if (p->name) {
      printf("STRING: %s \n", p->name);
    } else {
      printf("\n");
      ASTprint(level+1, p->s1);
    }
    break;
  case A_PARAMS:
    printf("%s", DataTypeToString(p->datatype));
    ASTprint(level+1, p->s1); // next parameter
    break;
  default:
    printf("unknown type in ASTprint %d\n", p->nodetype);
    printf("Exiting ASTprint immediately\n");
    exit(1);

  } // of switch
} // of ASTprint

const char* operator_to_string(enum OPERATORS operator) {
  switch (operator) {
    case A_PLUS:
      return "+";
    case A_MINUS:
      return "-";
    case A_TIMES:
      return "*";
    case A_LT:
      return "<";
    case A_GT:
      return ">";
    case A_LE:
      return "<=";
    case A_GE:
      return ">=";
    case A_EQ:
      return "==";
    case A_NE:
      return "!=";
    default:
      printf("ERROR! unknown operator in printExpression %d\n", operator);
      exit (-1);
  }
}

/* dummy main program so I can compile for syntax error independently
main()
{
}
/* */
