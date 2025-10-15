/*
Devon Sookhoo
October 12th, 2025
Lab 6 Abstract Syntax Tree
Enhancements:
  - Resolved multiple definition errors by moving ASTnode *program to ast.c
  - Resolved multiple definition errors by adding extern to ASTnode *program in ast.h
  - All enumerated types start with A_
  - Added operator_to_string function to convert enum OPERATORS to string for printing
  - Added AST types including: A_EXPRESSION_STATEMENT, A_ASSIGNMENT_STATEMENT, A_ITERATION_STAT
  - Implemented the PT() function to handle indentation in ASTprint
  - Implemented the DataTypeToString() function to convert enum DataTypes to string for printing
  - Implemented the ASTCreateNode() function to create and initialize AST nodes
  - Updated ASTprint to handle new AST types and print them appropriately
  - Added global variable "program" to ast.c and declared it as extern in ast.h
  - Added support for A_CONTINUE, A_BREAK, and A_RETURN in ASTprint
  - Created the operator_to_string() function to convert enum OPERATORS to string for printing
*/

#include <malloc.h>
#include <stdio.h>

#ifndef AST_H
#define AST_H
extern int mydebug; // defined in main.c

/* define the enumerated types for the AST.  This is used to tell us what
sort of production rule we came across */

enum ASTtype {
  A_VARDEC,               // Variable Declaration
  A_DEC_LIST,             // List of Declarations
  A_FUNCTIONDEC,          // Function Declaration
  A_FUNCTION_CALL,        // Function Call Argument
  A_ARG_LIST,             // The list of arguments in a function call
  A_ARGUMENT,             // A single argument in a function call
  A_NUMBER,               // Numeric Literal
  A_VARIABLE,             // Variable
  A_BOOLEAN,              // Boolean Literal
  A_EXPRESSION,           // Expression: + - * / etc.
  A_COMPOUND,             // Compound Statement: begin ... end
  A_STMT_LIST,            // List of Statements
  A_WRITE,                // Write Statement
  A_READ,                 // Read Statement
  A_PARAM,                // Function Declaration Parameter
  A_VOID_PARAM,           // Empty Parameter List
  A_EXPRESSION_STATEMENT, // Example: x + 5;
  A_ASSIGNMENT_STATEMENT, // Example: x = 5;
  A_ITERATION_STATEMENT,  // Example: while x < 10 do being .. end
  A_SELECTION_STATEMENT,  // Example: if x < 10 then ... else ... endif
  A_SELECTION_BODY,       // The body of an if statement
  A_FUNCTION_PROTOTYPE,   // Function Prototype
  A_CONTINUE,             // Continue Statement
  A_BREAK,                // Break Statement
  A_RETURN,               // Return Statement
};

enum DataTypes {
  A_INTTYPE,      // "int"
  A_VOIDTYPE,     // "void"
  A_BOOLEANTYPE,  // "boolean"
  A_UNKNOWN,      // used for undeclared variables
};

enum OPERATORS {
  A_PLUS,   // +
  A_MINUS,  // -
  A_TIMES,  // *
  A_DIVIDE, // /
  A_AND,    // AND
  A_OR,     // OR
  A_LT,     // <
  A_GT,     // >
  A_LE,     // <=
  A_GE,     // >=
  A_EQ,     // ==
  A_NE,     // !=
  A_NOT,    // NOT
};

/* define a type AST node which will hold pointers to AST structs that will
   allow us to represent the parsed code
*/
typedef struct ASTnodetype {
  enum ASTtype nodetype;    // Indicates which kind of node this is
  enum OPERATORS operator;  // Indicates which operator (if any) will be applied to the child nodes
  enum DataTypes datatype; // Indicates datatype of variable or function
  char *name;              // Name (T_ID) of variable or function
  int value;               // used for number values and also for array size
  struct ASTnodetype *s1, *s2; /* used for holding IF and WHILE components -- not very descriptive */
} ASTnode;

/* uses malloc to create an ASTnode and passes back the heap address of the newley created node */
ASTnode *ASTCreateNode(enum ASTtype mytype);

// Helper function to print tabbing
void PT(int howmany);

// declared as extern to resolve multiple definition errors
extern ASTnode *program; // pointer to the tree

/*  Print out the abstract syntax tree */
void ASTprint(int level, ASTnode *p);

// Convert DataType enum to string for printing
const char *operator_to_string(enum OPERATORS op);

#endif // of AST_H
