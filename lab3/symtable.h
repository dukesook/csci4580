#pragma once

#include <stdbool.h>


void Insert(); // Remove!!!
// void Insert(char *sym, int address); // takes a symbold and address and inserts if the symbold is not there

void Display();

void Delete(); // Remove!!!
// void Delete(char *s); // takes a symbols and removes it if present

bool Search(char *symbol); //takes a symbol and states if present or not returns 0 or 1.

struct SymbTab {
  char label[10];  // Remove!!!
  // char symbol[10]; // Remove!!!
  char *symbol;
  int addr;
  struct SymbTab *next;
};


// Helpers
int prompt_option();

char* prompt_search();

void log_search(bool symbol_found);

