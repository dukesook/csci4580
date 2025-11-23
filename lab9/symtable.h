/*
Devon Sookhoo
October 31st, 2025
Lab 7 Add Symbol Table and Type Checking
Enhancements:
  - Make struct SymbTab a typedef for easier usage
  - Added subtype_to_string() function
  - Added the PrintSym() prototype

*/

/*  Symbol Table --linked list  headers
    Used for Compilers class

    Modified Spring 2015 to allow for name to pointed to by symtable, instead of copied, since the name is copied
    into the heap

    Modified to have levels.  A level 0 means global variable, other levels means in range of the function.  We
    start out our offsets at 0 (from stack pointer) for level 1,,,when we enter a functional declaration.
    We increment offset each time we insert a new variable.  A variable is considered to be valid if it is found in
    the symbol table at our level or lesser level.  If at 0, then it is global.  

    We return a pointer to the symbol table when a variable matches our creteria.

    We add a routine to remove variables at our level and above.
*/

    


#ifndef _SYMTAB 
#define _SYMTAB

#include "ast.h"
#include <stdbool.h>

enum  SYMBOL_SUBTYPE
{
   SYM_SCALAR,   // scalar
   SYM_FUNCTION, // scalar
   SYM_FUNCTION_PROTO, // example: int f(void);
   SYM_FUNCTION_PRE, // example: int f, parameters & body is unknown
   SYM_ARRAY,
   SYM_ARRAY_PARAMETER,
   // missing for array as parameter
};

void Display();
int Delete();


typedef struct SymbTab
{
    char *name;
    int offset; /* from activation record boundary */
    int mysize;  /* number of words this item is 1 or more */
    int level;  /* the level where we found the variable */
    enum DataTypes Declared_Type;  /* the type of the symbol */
    enum SYMBOL_SUBTYPE SubType;  /* the subtype of the symbol */
    ASTnode * fparms; /* Function Parameters */
    struct SymbTab *next;
} SymbTab;


SymbTab * Insert(char *name, enum DataTypes, enum SYMBOL_SUBTYPE, int level, int size, int offset);

SymbTab * Search(char name[], int level, int recur );

static SymbTab *first=NULL;   /* global pointers into the symbol table */

char * CreateTemp();

const char* subtype_to_string(enum SYMBOL_SUBTYPE);

void PrintSym(struct SymbTab*);

int Has_Proto();

#endif

