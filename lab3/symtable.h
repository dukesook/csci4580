#pragma once

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

// Prompts the User to get the next option
int get_option();

// Handles the Insert Option
void HandleInsert();

// Handles the Delete Option
void HandleDelete();

// Handles the Search Option
void HandleSearch();