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
  emit_traverse_ast(root, fp, emit_string);
  
  // Globals
  fprintf(fp, "\n.align 2\n");
  // emit_globals(root, fp);
  emit_traverse_ast(root, fp, emit_global_variable);

  // Text
  fprintf(fp, "\n.text\n");

  // Main label
  fprintf(fp, "\n.globl main\n");

}

void emit_debug(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

  fprintf(stdout, "# Node Type: %s\n", ASTtype_to_string(node->nodetype));
}

void emit_traverse_ast(ASTnode* root, FILE* fp, void (*function)(ASTnode*, FILE*)) {
  if (!root) {
    return;
  }
  
  // Process current node
  function(root, fp);

  // Traverse children
  emit_traverse_ast(root->s1, fp, function);
  emit_traverse_ast(root->s2, fp, function);

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_global_variable(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

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

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
void emit_string(ASTnode* node, FILE* fp) {
  
  if (node->nodetype != A_WRITE) {
    return;
  } else if (node->name == NULL) {
    return;
  }
  char label[64];
  emit_create_label(label);
  fprintf(fp, "%s:  .asciiz %s\n", label, node->name);

}

// PRE: None
// POST: Creates and returns a unique label string
void emit_create_label(char* label) {
  if (!label) {
    printf("Error: NULL label pointer passed to emit_create_label()\n");
    exit(1);
  }

  static int label_count = 0;
  sprintf(label, "_L%d", label_count++);
}