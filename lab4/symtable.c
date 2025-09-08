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
#define MAX_SYMBOL_SIZE 11
struct SymbTab *first, *last;

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
