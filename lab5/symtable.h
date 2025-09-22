#pragma once
/*
Devon Sookhoo
September 22nd, 2025
Lab 5 Symbol Table with YACC
Assignment Description: Extend the single letter register names to variable names.

Enhancements:
  - New function: FetchAddress().
  - New function: GetNode().
  - Updated Insert() to use strdup for deep string copying.
  - Updated Search() to return bool instead of int.
  - Updated Delete() to return void instead of int.
  - Added comments to every function and major code block for clarity.

*/


/*
Devon Sookhoo
September 8th, 2025
Lab 3 Symbol Table
Assignment Description: Refactor the code to made it readable and parameterize each helper function.

Description of Code:
  - This header file was originally created by Devon Sookhoo.
  - It contains the function declarations pulled from symtable.c.
  - It also contains the struct definition for the symbol table.
  - The functions were parameterized for better reusability and clarity.
  - I also added helper functions so main wasn't too cluttered.
 */

#include <stdbool.h>

// The Primary Data Structure
struct SymbTab {
  char *symbol; // The representation of the token
  int addr;     // The address of the token in memory
  struct SymbTab *next; // Pointer to the next node
};

// takes a symbol and address and inserts if the symbold is not there
void Insert(char *symbol, int address);

// Displays the Main UI Options
void Display();

// takes a symbols and removes it if present
void Delete(char *symbol);

// takes a symbol and states if present or not returns 0 or 1.
bool Search(char *symbol);

// takes a symbol and returns its address in memory
int FetchAddress(char * symbol);

// Gets the node for a given symbol
struct SymbTab* GetNode(char *symbol);