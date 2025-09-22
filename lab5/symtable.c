/*
Devon Sookhoo
September 19th, 2025
Lab 4 Symbol Table with YACC
Assignment Description: Extend the single letter register names to variable names.

Enhancements:
  - Removed main() function.
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
  - The original code was found here: https://forgetcode.com/C/101-Symbol-table
  - The code implements a symbol table using a linked list in C.
  - Each function is parameterless, which is not ideal for reusability and clarity.
Enhancements:
    - Formatted code for better readability.
    - Updated Search(lab[]) to accept a char* instead.
    - Updated SymbTab.symbol to be a pointer instead of an array.
    - Completely removed Modify() function.
    - Removed label field from SymbTab struct and code.
    - Make SymbTab.symbol a pointer instead of an array.
    - Replaced strcpy with strdup to for deep string copying.
    - Commented every for loop.
    - Commented every if statement.
    - Commented every function.
*/

/*
Describe the main data structure in this code:
  - The main data structure is the Symbol Table.
  - The Symbol Table is implemented as a linked list using the struct SymbTab.
  - The struct SymbTab has three fields:
    - char *symbol: A pointer to a string that represents the symbol (token).
    - int addr: An integer representing the address of the symbol in memory.
    - struct SymbTab *next: A pointer to the next node in the linked list, allowing traversal through the symbol table.
    - The Symbol Table is built by dynamically allocating memory for each new symbol
      and linking them using the next pointer.
*/

#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"

int size = 0; // the number symbols in the symbol table
#define MAX_SYMBOL_SIZE 11 // max size of a symbol
struct SymbTab *first, *last; // pointers to the first and last nodes

// takes a symbol and address and inserts if the symbold is not there
void Insert(char *symbol, int address) {
  bool symbol_found;
  struct SymbTab *node;

  node = malloc(sizeof(struct SymbTab));
  node->symbol = strdup(symbol);
  node->addr = address;

  node->next = NULL;
  if (size == 0) { // handles the first insertion
    first = node;
    last = node;
  } else { // handles all other insertions
    last->next = node;
    last = node;
  } // end if else
  size++;
} // end of Insert()

// Displays the Main UI Options
void Display() {
  int i;
  struct SymbTab *p;
  p = first;
  printf("\n\tSYMBOL\t\tADDRESS\n");
  // For each symbol in the symbol table, print its details
  for (i = 0; i < size; i++) {
    printf("\t%s\t\t%d\n", p->symbol, p->addr);
    p = p->next;
  } // end for loop
} // end of Display()

// takes a symbols and removes it if present
bool Search(char* symbol) {
  int i, exists = 0;
  struct SymbTab *p;
  p = first;

  // Traverse the symbol table to check if the symbol exists
  for (i = 0; i < size; i++) {
    if (strcmp(p->symbol, symbol) == 0)
      exists = 1;
    p = p->next;
  } // end for loop
  return exists;
} // end of Search()

// takes a symbol and states if present or not returns 0 or 1.
void Delete(char *symbol) {
  bool found;
  struct SymbTab *p, *q;
  p = first;

  // Check if the first symbol is the one to be deleted
  if (strcmp(first->symbol, symbol) == 0)
    first = first->next;
  // Check if the last symbol is the one to be deleted
  else if (strcmp(last->symbol, symbol) == 0) {
    q = p->next;
    // Traverse to the second last node
    while (strcmp(q->symbol, symbol) != 0) {
      p = p->next;
      q = q->next;
    }
    p->next = NULL;
    last = p;
  } else {
    q = p->next;
    // Traverse the symbol table to find the symbol to be deleted
    while (strcmp(q->symbol, symbol) != 0) {
      p = p->next;
      q = q->next;
    } // end while loop
    p->next = q->next;
  } // end if else
  size--;
} // end of Delete()

// takes a symbol and returns its address in memory
int FetchAddress(char * symbol) {
  // This needs to look at the list and return the match address
  struct SymbTab * node = GetNode(symbol);
  if (node == NULL) {
    printf("Error: Symbol '%s' not found in the symbol table.\n", symbol);
    return (0); // Symbol not found
  }
  return (node->addr); // Return the address if found
}

// Gets the node for a given symbol
struct SymbTab* GetNode(char *symbol) {
  int i;
  struct SymbTab *p;
  p = first;

  // Traverse the symbol table to find the node with the given symbol
  for (i = 0; i < size; i++) {
    if (strcmp(p->symbol, symbol) == 0)
      return p; // Return the node if found
    p = p->next;
  } // end for loop
  return NULL; // Return NULL if the symbol is not found
} // end of GetNode()
