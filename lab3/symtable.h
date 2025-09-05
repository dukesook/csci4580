#pragma once

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

// Prompts the User to get the next option
int get_option();

// Handles the Insert Option
void HandleInsert();

// Handles the Delete Option
void HandleDelete();

// Handles the Search Option
void HandleSearch();