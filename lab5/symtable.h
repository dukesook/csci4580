#pragma once
/*
Devon Sookhoo
September 22nd, 2025
Lab 5 Symbol Table with YACC
Assignment Description: Implement The Context Free Grammar for ALGO-C

Enhancements:
  - This file was coppied from lab4/symtable.h
  - Removed the calculator comments from lab4.
  - No other changes were made for lab5.
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