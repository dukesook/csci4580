/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST
Enhancements:
  - Removed comments from previous labs
  - Added char* label to ASTnode struct for IF and WHILE labels

*/

#include <malloc.h>
#include <stdio.h>
#include "symtable.h"
#include <stdbool.h>

#ifndef AST_H
#define AST_H
extern bool mydebug; // defined in main.c

/* define the enumerated types for the AST.  This is used to tell us what
sort of production rule we came across */

enum ASTtype {
  A_VARDEC,               // s1 = Next Variable Declaration (if any), s2 = NULL
  A_DEC_LIST,             // s1 = Varaible or Function Declaration, s2 = next Declaration_List (if any)
  A_FUNCTIONDEC,          // Function Declaration
  A_PROTOTYPE,            // Function Prototype Declaration
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
  A_PARAM,                // s1 = Next Parameter (if any), s2 = NULL
  A_VOID_PARAM,           // Empty Parameter List
  A_EXPRESSION_STATEMENT, // Example: x + 5;
  A_ASSIGNMENT_STATEMENT, // Example: x = 5;
  A_ITERATION_STATEMENT,  // Example: while x < 10 do being .. end
  A_SELECTION_STATEMENT,  // Example: if x < 10 then ... else ... endif
  A_SELECTION_BODY,       // The body of an if statement
  A_CONTINUE,             // Continue Statement
  A_BREAK,                // Break Statement
  A_RETURN,               // Return Statement
};

enum DataTypes {
  A_INTTYPE,      // "int"
  A_VOIDTYPE,     // "void"
  A_BOOLEANTYPE,  // "boolean"
  A_DATATYPE_UNKNOWN,      // used for undeclared variables
};

enum OPERATORS {
  A_OPERATOR_UNKNOWN, // unknown operator
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
  enum ASTtype nodetype;        // Indicates which kind of node this is
  enum OPERATORS operator;      // Indicates which operator (if any) will be applied to the child nodes
  enum DataTypes datatype;      // Indicates datatype of variable or function
  char *name;                   // Name (T_ID) of variable or function
  char *label;                  // used for labels in IF and WHILE statements
  int value;                    // used for number values. varaibles: 0 = single variable. # = array size. -1 = not used
  struct ASTnodetype *s1, *s2;  // used for holding IF and WHILE components -- not very descriptive
  struct SymbTab *symbol;       // Pointer to symbol table entry for this node
  bool is_array;              // true if this variable node represents an array element (e.g., x[5]
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
const char *operator_to_string(enum OPERATORS);

// Convert ASTtype enum to string for printing
char *ASTtype_to_string(enum ASTtype);

// Convert DataTypes enum to string for printing
char* DataTypes_to_string(enum DataTypes);

#endif // of AST_H
