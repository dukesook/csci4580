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
void EMIT(ASTnode* p, FILE* fp) {

  fprintf(fp, "# MIPS code generated from AST\n");
  fprintf(fp, ".data\n\n");
  fprintf(fp, ".align 2\n\n");
  fprintf(fp, ".text\n\n");
  fprintf(fp, ".globl main\n\n");

}