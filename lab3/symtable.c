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
*/

/*
TODO
  - A screenshot of at least 4 actions (Demonstrate that you understand the code by testing the functionality of the interface.)
  - Describe the main data structure in this code.  What is it's name?  What are the fields and how is the structure built
  - for loop comments
  - if comments
  - function comments
*/

#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"

int size = 0; // the number symbols in the symbol table
#define MAX_SYMBOL_SIZE 11
struct SymbTab *first, *last;

void main() {
  int option;
  bool found;
  char *symbol;
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
  if (size == 0) {
    first = node;
    last = node;
  } else {
    last->next = node;
    last = node;
  }
  size++;
}

void Display() {
  int i;
  struct SymbTab *p;
  p = first;
  printf("\n\tSYMBOL\t\tADDRESS\n");
  for (i = 0; i < size; i++) {
    printf("\t%s\t\t%d\n", p->symbol, p->addr);
    p = p->next;
  }
}

bool Search(char* symbol) {
  int i, exists = 0;
  struct SymbTab *p;
  p = first;
  for (i = 0; i < size; i++) {
    if (strcmp(p->symbol, symbol) == 0)
      exists = 1;
    p = p->next;
  }
  return exists;
}

void Delete(char *symbol) {
  bool found;
  struct SymbTab *p, *q;
  p = first;

  if (strcmp(first->symbol, symbol) == 0)
    first = first->next;
  else if (strcmp(last->symbol, symbol) == 0) {
    q = p->next;
    while (strcmp(q->symbol, symbol) != 0) {
      p = p->next;
      q = q->next;
    }
    p->next = NULL;
    last = p;
  } else {
    q = p->next;
    while (strcmp(q->symbol, symbol) != 0) {
      p = p->next;
      q = q->next;
    }
    p->next = q->next;
  }
  size--;
}


// Helpers Functions

int get_option() {
  int option;
  printf("\n\tSYMBOL TABLE IMPLEMENTATION\n");
  printf("\n\t1.INSERT\n\t2.DISPLAY\n\t3.DELETE\n\t4.SEARCH\n\t5.END\n");
  printf("\n\tEnter your option : ");
  scanf("%d", &option);
  return option;
}

void HandleInsert() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the symbol : ");
  scanf("%s", symbol);
  found = Search(symbol);

  if (found) {
    printf("\n\tThe symbol exists already in the symbol table\n");
    printf("\tDuplicate can't be inserted\n");
  } else {
    int address;
    printf("\n\tEnter the address : ");
    scanf("%d", &address);
    Insert(symbol, address);
    printf("\n\tSymbol inserted\n");
  }
}

void HandleDelete() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the symbol to be deleted : ");
  scanf("%s", symbol);
  found = Search(symbol);
  if (!found) {
    printf("\n\tSymbol not found\n");
  } else {
    Delete(symbol);
    printf("\n\tAfter Deletion:\n");
    Display();
  }
}

void HandleSearch() {
  char symbol[MAX_SYMBOL_SIZE];
  bool found;

  printf("\n\tEnter the Symbol to be searched : ");
  scanf("%s", symbol);

  found = Search(symbol);

  printf("\n\tSearch Result:");
  if (found)
    printf("\n\tSymbol FOUND in symbol table\n");
  else
    printf("\n\tSYMBOL NOT FOUND!\n");
}