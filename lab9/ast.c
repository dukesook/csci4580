/*
Devon Sookhoo
October 31st, 2025
Lab 7 Add Symbol Table and Type Checking
Enhancements:
  - Removed comments from previous labs
  - Updated date and lab info
  - Added DataTypes_to_string() function to convert enum DataTypes to string for printing
  - Added ASTtype_to_string() function to convert enum ASTtype to string for printing
  - Added operator_to_string() function to convert enum OPERATORS to string for printing  

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
  p->operator = A_OPERATOR_UNKNOWN;       // Indicates which operator (if any) will be applied to the child nodes
  p->datatype = A_DATATYPE_UNKNOWN;       // Indicates datatype of variable or function
  p->name = NULL;                         // Name (T_ID) of variable or function
  p->label = NULL;                        // used for labels in IF and WHILE statements
  p->s1 = NULL;                           // Child node #1
  p->s2 = NULL;                           // Child node #2
  p->value = -1;                          // used for number values and also for array size
  p->symbol = NULL;                       // Pointer to symbol table entry for this node
  p->is_array = false;                    // true if this variable node represents an array element (e.g., x[5]
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
    printf("Unknown type in DataTypeToString(): %d\n", mydatatype); // error
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
    ASTprint(level, p->s2); // Next A_DEC_LIST (if any)
    ASTprint(level, p->s1); // Varaible or Function Declaration
    break;

  case A_VARDEC:
    PT(level);
    printf("Variable ");
    printf("%s ", DataTypeToString(p->datatype));
    printf(" %s", p->name); // variable name
    if (p->value > 0) // if variable is an array
      printf("[%d]", p->value); // print array size
    printf(" with offset %d and level %d\n", p->symbol->offset, p->symbol->level);
    ASTprint(level, p->s1); // next variable declaration (if any)
    break;

  case A_FUNCTIONDEC:
    PT(level);
    printf("Function ");
    printf("%s  ", DataTypeToString(p->datatype)); // return type
    printf("%s", p->name);                         // function name
    printf(" with size %d", p->symbol->mysize);
    ASTprint(level + 1, p->s1);                    // parameters
    ASTprint(level + 1, p->s2);                    // compound
    break;

  case A_PROTOTYPE:
    PT(level);
    char *type = DataTypeToString(p->datatype);
    printf("Function PROTOTYPE %s  %s with size %d", type, p->name, p->symbol->mysize);
    ASTprint(level + 1, p->s1); // parameters
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
      printf("  offset %d level %d\n", param->symbol->offset, param->symbol->level);
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
    printf("VAR with name: %s offset: %d level: %d\n", p->name, p->symbol->offset,
           p->symbol->level);

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
  case A_OPERATOR_UNKNOWN:
    return "UNKNOWN!";
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


// PRE: The AST type to convert
// POST: A string representation of the AST type
char *ASTtype_to_string(enum ASTtype type) {
  switch (type) { // switch on the type
  case A_VARDEC:
    return "A_VARDEC";
  case A_DEC_LIST:
    return "A_DEC_LIST";
  case A_FUNCTIONDEC:
    return "A_FUNCTIONDEC";
  case A_FUNCTION_CALL:
    return "A_FUNCTION_CALL";
  case A_ARG_LIST:
    return "A_ARG_LIST";
  case A_ARGUMENT:
    return "A_ARGUMENT";
  case A_NUMBER:
    return "A_NUMBER";
  case A_VARIABLE:
    return "A_VARIABLE";
  case A_BOOLEAN:
    return "A_BOOLEAN";
  case A_EXPRESSION:
    return "A_EXPRESSION";
  case A_COMPOUND:
    return "A_COMPOUND";
  case A_STMT_LIST:
    return "A_STMT_LIST";
  case A_WRITE:
    return "A_WRITE";
  case A_READ:
    return "A_READ";
  case A_PARAM:
    return "A_PARAM";
  case A_VOID_PARAM:
    return "A_VOID_PARAM";
  case A_EXPRESSION_STATEMENT:
    return "A_EXPRESSION_STATEMENT";
  case A_ASSIGNMENT_STATEMENT:
    return "A_ASSIGNMENT_STATEMENT";
  case A_ITERATION_STATEMENT:
    return "A_ITERATION_STATEMENT";
  case A_SELECTION_STATEMENT:
    return "A_SELECTION_STATEMENT";
  case A_SELECTION_BODY:
    return "A_SELECTION_BODY";
  case A_CONTINUE:
    return "A_CONTINUE";
  case A_BREAK:
    return "A_BREAK";
  case A_RETURN:
    return "A_RETURN";
  case A_PROTOTYPE:
    return "A_PROTOTYPE";
  default:
    return "UNKNOWN_ASTTYPE";
  } // end of switch
}

// PRE: a Data Type to convert
// POST: a character string for that type to print nicely -- caller does final output
char* DataTypes_to_string(enum DataTypes datatype) {
  switch (datatype) { // switch on the type
  case A_INTTYPE:
    return "int";
  case A_VOIDTYPE:
    return "void";
  case A_BOOLEANTYPE:
    return "boolean";
  case A_DATATYPE_UNKNOWN:
    return "A_DATATYPE_UNKNOWN";
  default:
    return "UNKNOWN_DATATYPE";
  } // end of switch
}
