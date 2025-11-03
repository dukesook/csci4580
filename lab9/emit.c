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
  fprintf(fp, "\n.data\n");
  
  // Globals
  fprintf(fp, "\n.align 2\n");
  emit_globals(root, fp);

  // Text
  fprintf(fp, "\n.text\n");

  // Main label
  fprintf(fp, "\n.globl main\n");

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_globals(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

  // Emit Children
  emit_globals(node->s1, fp);
  emit_globals(node->s2, fp);

  if (!node->symbol) {
    return; // No symbol table entry
  } else if (node->symbol->level != 0) {
    return; // Not a global variable
  }

  if (node->nodetype == A_VARDEC) {
    char* type = ASTtype_to_string(node->nodetype);
    printf("%s", type);
    int size = node->value * WSIZE; // size in bytes
    printf("\n");


    fprintf(fp, "%s: .space %d  # global variable\n", node->name, size);
  }

  


}