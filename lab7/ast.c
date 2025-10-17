/*
Devon Sookhoo
October 12th, 2025
Lab 6 Abstract Syntax Tree
Enhancements:
  - Moved ASTnode *program to ast.c to avoid multiple definition errors
  - Added support for A_CONTINUE, A_BREAK, and A_RETURN in ASTprint
  - Added operator_to_string function to convert enum OPERATORS to string for printing
  - Added AST types including: A_EXPRESSION_STATEMENT, A_ASSIGNMENT_STATEMENT, A_ITERATION_STAT
  - Implemented the PT() function to handle indentation in ASTprint
  - Implemented the DataTypeToString() function to convert enum DataTypes to string for printing
  - Implemented the ASTCreateNode() function to create and initialize AST nodes
  - Updated ASTprint to handle new AST types and print them appropriately
  - Added global variable "program" to ast.c and declared it as extern in ast.h
  - Created the operator_to_string() function to convert enum OPERATORS to string for printing
  - Documented the PRE and POST conditions for functions
*/

#include "ast.h"
#include <malloc.h>
#include <stdio.h>
#include <stdlib.h>

ASTnode *program; // pointer to the tree

/* uses malloc to create an ASTnode and passes back the heap address of the
 * newley created node */
// PRE: Given an AST type
// POST: Return pointer to new AST node with type set and other fields initialized to NULL/0
ASTnode *ASTCreateNode(enum ASTtype mytype) {
  ASTnode *p;
  if (mydebug)
    fprintf(stderr, "Creating AST Node \n");
  p = (ASTnode *)malloc(sizeof(ASTnode)); // allocate memory
  p->nodetype = mytype;                   // Indicates which kind of node this is
  p->s1 = NULL;                           // Child node #1
  p->s2 = NULL;                           // Child node #2
  p->value = 0;                           // used for number values and also for array size
  return (p);
} // end of ASTCreateNode()

/*  Helper function to print tabbing */
// PRE: Given a positive integer
// POST: Print that number of tabs
void PT(int howmany) {
  for (int i = 0; i < howmany; i++) {
    printf(" ");
  }
} // end of PT()

// PRE: a Data Type
// POST: a character string for that type to print nicely -- caller does final output
char *DataTypeToString(enum DataTypes mydatatype) {
  switch (mydatatype) { // switch on the type
  case A_VOIDTYPE:
    return ("void");  // return string "void"
  case A_INTTYPE:
    return ("int"); // return string "int"
  case A_BOOLEANTYPE:
    return ("boolean"); // return string "boolean"
  default:
    printf("Unknown type in DataTypeToString\n"); // error
    exit(1); // barf
  } // end of switch
} // end of DataTypeToString()

/*  Print out the abstract syntax tree */
// PRE: Pointer to an AST Tree
// POST: Print formatted tree output
void ASTprint(int level, ASTnode *p) {
  // Check for NULL pointer
  if (p == NULL)
    return; // nothing to print

  // when here p is not NULL
  switch (p->nodetype) {
  case A_DEC_LIST:
    PT(level);
    ASTprint(level, p->s1); // Declaration (list)
    ASTprint(level, p->s2); // Declaration (if additional)
    break;

  case A_VARDEC:
    PT(level);
    printf("Variable ");
    printf("%s ", DataTypeToString(p->datatype));
    printf(" %s", p->name); // variable name
    if (p->value > 0) // if variable is an array
      printf("[%d]", p->value); // print array size
    printf(" with offset %d ", p->symbol->offset);
    printf("\n");
    ASTprint(level, p->s1);
    break;

  case A_FUNCTIONDEC:
    PT(level);
    printf("Function ");
    printf("%s  ", DataTypeToString(p->datatype)); // return type
    printf("%s", p->name);                         // function name
    ASTprint(level + 1, p->s1);                    // parameters
    ASTprint(level + 1, p->s2);                    // compound
    break;

  case A_NUMBER:
    PT(level);
    printf("NUM with value %d\n", p->value);
    break;

  case A_EXPRESSION:
    PT(level);
    const char *operator= operator_to_string(p->operator);
    printf("EXPR  %s\n", operator); // The operator being applied
    ASTprint(level + 1, p->s1); // left side of the expression
    ASTprint(level + 1, p->s2); // right side of the expression
    break;

  case A_BOOLEAN:
    PT(level);
    if (p->value == 1) {
      printf("BOOLEAN with value TRUE\n");
    } else {
      printf("BOOLEAN with value FALSE\n");
    }

  case A_COMPOUND:
    PT(level);
    printf("BEGIN\n");
    ASTprint(level + 1, p->s1); // Local Declarations
    ASTprint(level + 1, p->s2); // Statement List
    PT(level);
    printf("END\n");
    break;

  case A_STMT_LIST:
    // PT(level);
    ASTprint(level, p->s1); // Statement
    ASTprint(level, p->s2); // Statement List
    break;

  case A_WRITE:
    PT(level);
    printf("WRITE\n");
    if (p->name) { // p->name is a string literal
      PT(level + 1);
      printf("STRING: %s\n", p->name);
    } else {
      ASTprint(level + 1, p->s1); // Writing an expression
    }
    break;

  case A_VOID_PARAM:
    printf("(VOID)\n");
    break;

  case A_PARAM:
    printf("\n");
    PT(level);
    printf("(\n");
    ASTnode *param = p; // start of parameter list
    while (param != NULL) { // iterate through parameters
      PT(level + 1);
      printf("parameter %s  %s", DataTypeToString(param->datatype), param->name);
      if (param->value == 1) {
        printf("[]"); // array parameter
      }
      printf(" with offset %d\n", param->symbol->offset);
      printf("\n");
      param = param->s1; // next parameter
    }
    PT(level);
    printf(")\n");
    break;

  case A_READ:
    PT(level);
    printf("READ\n");
    ASTprint(level + 1, p->s1); // Variable
    break;

  case A_VARIABLE:
    PT(level);
    printf("VAR with name %s\n", p->name);

    // If variable is an array
    if (p->s1) {
      PT(level + 1);
      printf("[\n");              // print opening bracket for array
      ASTprint(level + 2, p->s1); // Expression for array index
      PT(level + 1);
      printf("]\n"); // print closing bracket for array
    }
    break;

  case A_FUNCTION_CALL:
    PT(level);
    printf("CALL %s\n", p->name); // function name
    ASTprint(level + 1, p->s1); // Arguments (A_ARG_LIST)
    break;

  case A_ARG_LIST:
    PT(level);
    printf("(\n");
    ASTprint(level + 1, p->s1); // First Argument
    PT(level); // Print tab for closing parenthesis
    printf(")\n");
    break;

  case A_ARGUMENT:
    PT(level);
    printf("CALL ARGUMENT\n");
    ASTprint(level + 1, p->s1); // Print Current Argument
    ASTprint(level, p->s2);     // Print Next Argument
    break;

  case A_ASSIGNMENT_STATEMENT:
    PT(level);
    printf("ASSIGNMENT\n");

    PT(level + 1);
    printf("LEFT HAND SIDE\n");
    ASTprint(level + 2, p->s1); // Variable to be assigned

    PT(level + 1);
    printf("RIGHT HAND SIDE\n");
    ASTprint(level + 2, p->s2); // Expression
    break;

  case A_ITERATION_STATEMENT:
    PT(level);
    printf("WHILE\n"); // While loop

    PT(level + 1);
    printf("CONDITION\n");
    ASTprint(level + 2, p->s1); // Condition

    PT(level + 1);
    printf("WHILE BODY\n");

    ASTprint(level + 2, p->s2); // Body

    break;

  case A_SELECTION_STATEMENT:
    PT(level);
    printf("IF Statement\n"); // If statement

    PT(level + 1);
    printf("CONDITION\n");
    ASTprint(level + 2, p->s1); // Condition

    PT(level + 1);
    printf("IF BODY\n");
    ASTprint(level + 1, p->s2); // Then branch
    break;

  case A_SELECTION_BODY:
    ASTprint(level + 1, p->s1); // Body of if statement

    if (p->s2) { // If there is an else branch
      PT(level);
      printf("ELSE\n");
    }
    ASTprint(level, p->s2); // Else branch
    break;

  case A_EXPRESSION_STATEMENT:
    PT(level);
    printf("Expression Statement\n");
    ASTprint(level + 1, p->s1); // Expression
    break;

  case A_FUNCTION_PROTOTYPE:
    PT(level);
    char *type = DataTypeToString(p->datatype); // return type
    printf("Function PROTOTYPE %s  %s", type, p->name);
    ASTprint(level + 1, p->s1); // parameters
    break;

  case A_CONTINUE:
    PT(level);
    printf("CONTINUE\n"); // required for graduate students
    break;

  case A_BREAK:
    PT(level);
    printf("BREAK\n");  // required for graduate students
    break;

  case A_RETURN:
    PT(level);
    printf("RETURN\n");  // required for graduate students
    ASTprint(level + 1, p->s1); // The Return Expression
    break;

  default:
    printf("Error! ASTprint() - unknown type: %d\n", p->nodetype);
    printf("Exiting ASTprint immediately\n");
    exit(1);

  } // end of switch
} // end of ASTprint

// PRE: an operator enum
// POST: a character string for that operator to print nicely -- caller does final output
const char *operator_to_string(enum OPERATORS operator) {
  switch (operator) { // switch on the operator
  case A_PLUS:
    return "+";
  case A_MINUS:
    return "-";
  case A_TIMES:
    return "*";
  case A_DIVIDE:
    return "/";
  case A_AND:
    return "AND";
  case A_OR:
    return "OR";
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
  case A_NOT:
    return "NOT";
  default:
    printf("ERROR! operator_to_string() - unknown operator: %d\n", operator);
    exit(-1);
  } // end of switch
} // end of operator_to_string()

/* dummy main program so I can compile for syntax error independently
main()
{
}
/* */
