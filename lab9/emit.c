/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST

emit.c is the emitter file for compilers with MIPS.
Set of functions to create proper MIPS code and place it in the appropriate opened file.

Enhancements:
  - Created emit.h and emit.c files to handle MIPS code generation
*/

#include "emit.h"

// PRE: ASTnode pointer p, file pointer fp
// POST: All MIPS code directly and through helper functions
//       prints in the file via the file pointer.
void EMIT(ASTnode* root, FILE* fp) {

  fprintf(fp, "# MIPS code generated from AST\n");
  
  // Data
  fprintf(fp, ".data\n\n");
  
  // Globals
  fprintf(fp, ".align 2\n\n");
  emit_globals(root, fp);

  // Text
  fprintf(fp, ".text\n\n");

  // Main label
  fprintf(fp, ".globl main\n\n");

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_globals(ASTnode* root, FILE* fp) {
  // TODO
}