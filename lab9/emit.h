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


typedef void (*CallbackFn)(ASTnode*, FILE*);
typedef CallbackFn (*EmitFunction)(ASTnode*, FILE*);

#define WSIZE 4
#define LOG_WSIZE 2

// PRE: ASTnode pointer p, file pointer fp
// POST: Generates MIPS code from the AST and writes it to the file
void EMIT(ASTnode*, FILE*);

// PRE: Pointer to astnode
// POST: Main driver for walking out AST Tree to produce
//     MIPS code by calling appropriate helper functions
CallbackFn emit_node(ASTnode*, FILE*);

// PRE: file pointer fp, char pointers label, command, comment
// POST: Emits a MIPS command with optional label and comment
void emit_command(FILE*, char* label, char* command, char* comment);

// PRE: file pointer fp, char pointer line, char pointer comment
// POST: Emits a line of MIPS code with an optional comment
void emit_line(FILE*, char* line, char* comment);

// PRE: ASTnode pointer p, file pointer fp, function pointer for traversal
// POST: Traverses the AST and applies the given function to each node
void emit_traverse_ast(ASTnode*, FILE*, EmitFunction);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
CallbackFn emit_global_variable(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
CallbackFn emit_string(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for function declarations
CallbackFn emit_function_declaration(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for expressions
CallbackFn emit_expression(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for function tail
void emit_function_tail(ASTnode* p, FILE* fp);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for read statements
CallbackFn emit_read(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for write statements
CallbackFn emit_write(ASTnode*, FILE*);

// PRE: ASTnode pointer p, file pointer fp
// POST: $a0 will be the memory location of the varible.
CallbackFn emit_variable(ASTnode*, FILE*);

// PRE: char pointer label
// POST: Creates and returns a unique label string
char* emit_create_label();

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits debug information for the given AST node
void emit_debug(ASTnode*, FILE*);

// PRE: file pointer fp, char pointer comment
// POST: Emits a comment line in MIPS code
void emit_comment(FILE* fp, char* comment);


#endif // EMIT_H

// $ java -jar Mars.jar sm file.asm