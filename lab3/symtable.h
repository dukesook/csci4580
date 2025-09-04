#pragma once

#include <stdbool.h>

void Insert(char *symbol, int address); // takes a symbol and address and inserts if the symbold is not there

void Display();

// void Delete(); // Remove!!!
void Delete(char *symbol); // takes a symbols and removes it if present

bool Search(char *symbol); //takes a symbol and states if present or not returns 0 or 1.

struct SymbTab {
  char *symbol;
  int addr;
  struct SymbTab *next;
};


// Helper Functions
int get_option();

void HandleInsert();

void HandleDelete();

void HandleSearch();