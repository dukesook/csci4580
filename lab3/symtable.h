#pragma once

#include <stdbool.h>


// void Insert(); // Remove!!!
void Insert(char *symbol, int address); // takes a symbol and address and inserts if the symbold is not there

void Display();

void Delete(); // Remove!!!
// void Delete(char *s); // takes a symbols and removes it if present

bool Search(char *symbol); //takes a symbol and states if present or not returns 0 or 1.

struct SymbTab {
  char *symbol;
  int addr;
  struct SymbTab *next;
};


// Helpers
int prompt_option();

char* prompt_search();

void log_search(bool symbol_found);

