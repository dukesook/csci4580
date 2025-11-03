/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST
Enhancements:
  - Created emit.h and emit.c files to handle MIPS code generation
*/

#ifndef EMIT_H
#define EMIT_H

#include "ast.h"

#define WSIZE 4
#define LOG_WSIZE 2

// PRE: ASTnode pointer p, file pointer fp
// POST: Generates MIPS code from the AST and writes it to the file
void EMIT(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp, function pointer for traversal
void emit_traverse_ast(ASTnode*, FILE*, void (*func)(ASTnode*, FILE*));

void emit_debug(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_global_variable(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
void emit_string(ASTnode*, FILE*);

#endif // EMIT_H