/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST
Enhancements:
  - Created emit.h and emit.c files to handle MIPS code generation
  - #include <stdlib.h> in emit.h for exit()
  - #include <string.h> for strcmp()
*/

#ifndef EMIT_H
#define EMIT_H

#include <stdlib.h>
#include <string.h>
#include "ast.h"

#define WSIZE 4
#define LOG_WSIZE 2

// PRE: ASTnode pointer p, file pointer fp
// POST: Generates MIPS code from the AST and writes it to the file
void EMIT(ASTnode*, FILE*);

// PRE: Pointer to astnode
// POST: Main driver for walking out AST Tree to produce
//     MIPS code by calling appropriate helper functions
void emit_ast(ASTnode*, FILE*);

// PRE: file pointer fp, char pointers label, command, comment
// POST: Emits a MIPS command with optional label and comment
void emit_command(FILE*, char* label, char* command, char* comment);

// PRE: ASTnode pointer p, file pointer fp, function pointer for traversal
// POST: Traverses the AST and applies the given function to each node
void emit_traverse_ast(ASTnode*, FILE*, void (*func)(ASTnode*, FILE*));

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_global_variable(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
void emit_string(ASTnode*, FILE*);

// PRE: char pointer label
// POST: Creates and returns a unique label string
void emit_create_label(char* label);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits debug information for the given AST node
void emit_debug(ASTnode*, FILE*);


#endif // EMIT_H