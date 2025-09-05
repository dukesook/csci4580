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

// Main Function
void main() {
  int option;
  bool found;
  char *symbol;
  
  // Main Loop - Gets the option and calls the appropriate handler
  do {
    option = get_option();
    switch (option) {
    case 1: // Insert
      HandleInsert();
      break;
    case 2: // Display
      Display();
      break;
    case 3: // Delete
      HandleDelete();
      break;
    case 4: // Search
      HandleSearch();
      break;
    case 5: // End
      exit(0);
    }
  } while (option < 5);

} /* end of main */

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

// Prompts the User to get the next option
int get_option() {
  int option;
  printf("\n\tSYMBOL TABLE IMPLEMENTATION\n");
  printf("\n\t1.INSERT\n\t2.DISPLAY\n\t3.DELETE\n\t4.SEARCH\n\t5.END\n");
  printf("\n\tEnter your option : ");
  scanf("%d", &option);
  return option;
} // end of get_option()

// Handles the Insert Option
void HandleInsert() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the symbol : ");
  scanf("%s", symbol);
  found = Search(symbol);

  // Check if the symbol already exists
  if (found) {
    printf("\n\tThe symbol exists already in the symbol table\n");
    printf("\tDuplicate can't be inserted\n");
  } else { // symbol does not exist, proceed with insertion
    int address;
    printf("\n\tEnter the address : ");
    scanf("%d", &address);
    Insert(symbol, address);
    printf("\n\tSymbol inserted\n");
  } // end if else
} // end of HandleInsert()

// Handles the Delete Option
void HandleDelete() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the symbol to be deleted : ");
  scanf("%s", symbol);
  found = Search(symbol);
  if (!found) { // check if symbol was not found
    printf("\n\tSymbol not found\n");
  } else { // symbol was found
    Delete(symbol);
    printf("\n\tAfter Deletion:\n");
    Display(); 
  }
} // end of HandleDelete()

// Handles the Search Option
void HandleSearch() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the Symbol to be searched : ");
  scanf("%s", symbol);

  found = Search(symbol);

  printf("\n\tSearch Result:");
  if (found) // check if symbol was found
    printf("\n\tSymbol FOUND in symbol table\n");
  else // symbol was not found
    printf("\n\tSYMBOL NOT FOUND!\n");
} // end of HandleSearch()