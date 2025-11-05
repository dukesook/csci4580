/*
Devon Sookhoo
December 5th, 2025
Lab 9 ALGOL Create MIPS code from you AST

emit.c is the emitter file for compilers with MIPS.
Set of functions to create proper MIPS code and place it in the appropriate opened file.

Enhancements:
  - Created emit.h and emit.c files to handle MIPS code generation
  - #include <string.h> for strcmp()

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
  emit_traverse_ast(root, fp, emit_global_variable);

  // Text
  fprintf(fp, "\n.text\n");

  // Main label
  fprintf(fp, "\n.globl main\n");
  emit_traverse_ast(root, fp, emit_node);


} // end of EMIT()

// PRE: Pointer to astnode
// POST: Main driver for walking out AST Tree to produce
//     MIPS code by calling appropriate helper functions
CallbackFn emit_node(ASTnode* p, FILE* fp) {

  if (!p) {
    return NULL;
  }

  char* type = ASTtype_to_string(p->nodetype);

  switch (p->nodetype) {
    case A_DEC_LIST:
    case A_VARDEC:
    case A_COMPOUND:
    case A_STMT_LIST:
      // do nothing
      break;
    case A_FUNCTIONDEC:
      emit_function_declaration(p, fp);
      return emit_function_tail;
      break;
    case A_WRITE:
      emit_write(p, fp);
      break;
    case A_PROTOTYPE:
    case A_FUNCTION_CALL:
    case A_ARG_LIST:
    case A_ARGUMENT:
    case A_NUMBER:
    case A_VARIABLE:
    case A_BOOLEAN:
    case A_EXPRESSION:
    case A_READ:
    case A_PARAM:
    case A_VOID_PARAM:
    case A_EXPRESSION_STATEMENT:
    case A_ASSIGNMENT_STATEMENT:
    case A_ITERATION_STATEMENT:
    case A_SELECTION_STATEMENT:
    case A_SELECTION_BODY:
    case A_FUNCTION_PROTOTYPE:
    case A_CONTINUE:
    case A_BREAK:
    case A_RETURN:
    default:
      printf("emit_ast(): ERROR! Unhandled node type %s\n", type);
      // exit(1);
  } // end of switch(p->nodetype)

  return NULL;


} // end of emit_ast()

// PRE: file pointer fp, char pointers label, command, comment
// POST: Emits a MIPS command with optional label and comment
void emit_command(FILE* fp, char* label, char* command, char* comment) {
  if (strcmp("", comment) == 0) {
    if (strcmp("", label) == 0) {
      fprintf(fp, "\t%s\t\t\n", command);
    } else {
      fprintf(fp, "%s:\t%s\t\t\\n", label, command);
    }
  } else {
    if (strcmp("", label) == 0) {
      fprintf(fp, "\t%s\t\t# %s\n", command, comment);
    } else {
      fprintf(fp, "%s:\t%s\t\t# %s\n", label, command, comment);
    }
  }
} // of emit_command()

// PRE: ASTnode pointer p, file pointer fp, function pointer for traversal
// POST: Traverses the AST and applies the given function to each node
void emit_traverse_ast(ASTnode* node, FILE* fp, EmitFunction function) {
  if (!node) {
    return;
  }
  
  // Process current node
  CallbackFn callback = function(node, fp);

  // Traverse children
  emit_traverse_ast(node->s1, fp, function);
  emit_traverse_ast(node->s2, fp, function);

  if (callback) {
    callback(node, fp);
  }

} // end of emit_traverse_ast()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
CallbackFn emit_global_variable(ASTnode* node, FILE* fp) {
  if (!node) {
    return NULL;
  }

  if (!node->symbol) {
    return NULL;// No symbol table entry
  } else if (node->symbol->level != 0) {
    return NULL;// Not a global variable
  }

  if (node->nodetype == A_VARDEC) {
    char* type = ASTtype_to_string(node->nodetype);
    printf("%s", type);
    int size = node->value * WSIZE; // size in bytes
    printf("\n");


    fprintf(fp, "%s: .space %d  # global variable\n", node->name, size);
  }

  return NULL;

} // end of emit_global_variable()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
CallbackFn emit_string(ASTnode* node, FILE* fp) {
  
  if (node->nodetype != A_WRITE) {
    return NULL;
  } else if (node->name == NULL) {
    return NULL;
  }

  char label[64];
  emit_create_label(label);
  fprintf(fp, "%s:  .asciiz %s\n", label, node->name);

  return NULL;

} // end of emit_string()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for function declarations
CallbackFn emit_function_declaration(ASTnode* p, FILE* fp) {

  char s[256];
  int size = p->symbol->offset * WSIZE; // size in bytes
  sprintf(s, "subu $a0, $sp, %d", size);

  emit_command(fp, p->name, "", "Start of function");
  fprintf(fp, "\n");
  emit_command(fp, "", s, "adjust the stack for function setup");
  emit_command(fp, "", "sw $sp, ($a0)", "remember old SP");
  emit_command(fp, "", "sw $ra, 4($a0)", "remember current Return address");
  emit_command(fp, "", "move $sp, $a0", "adjust the stack pointer");
  fprintf(fp, "\n");
  fprintf(fp, "\n");

  // emit_node(p->s2, fp); // Call for compound statement (function body)



	// li $a0, 0		# RETURN has no specified value set to 0
	// lw $ra 4($sp)		# restore old environment RA
	// lw $sp ($sp)		# Return from function store SP

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for function tail
void emit_function_tail(ASTnode* p, FILE* fp) {

  emit_command(fp, "", "li $a0, 0", "restore RA");
  emit_command(fp, "", "lw $ra, 4($sp)", "restore old environment RA");
  emit_command(fp, "", "lw $sp, ($sp)", "Return from function store SP");

  if (strcmp(p->name, "main") == 0) {
    emit_command(fp, "", "li $v0, 10", "Exit from Main we are done");
    emit_command(fp, "", "syscall", "EXIT everything");
    // li $v0, 10		# Exit from Main we are done
	  // syscall			# EXIT everything
  } else {
    // TODO! normal function return;
    printf("# TODO! normal function return;\n");
    exit(1);
  }

}


// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for write statements
CallbackFn emit_write(ASTnode* p, FILE* fp) {
  // There are type types of write:
  //    1. String
  //    2. Expression

  char label[64];
  emit_create_label(label);
  
  if (p->name) {
    // String
    char s[100];
    sprintf(s, "la $a0, %s", label);
    emit_command(fp, "", "li $v0, 4", "# print a string");
    emit_command(fp, "", s, "# print fetch string location");
    emit_command(fp, "", "syscall", "Perform a write string");
    // li $v0, 4		# #print a string
    // la $a0, _L0		# #print fetch string location
    // syscall		# Perform a write string
  } else {
    // Expression

  }

  fprintf(fp, "\n");
  fprintf(fp, "\n");

} // end of emit_write()

// PRE: None
// POST: Creates and returns a unique label string
void emit_create_label(char* label) {
  if (!label) {
    printf("Error: NULL label pointer passed to emit_create_label()\n");
    exit(1);
  }

  static int label_count = 0;
  sprintf(label, "_L%d", label_count++);
} // end of emit_create_label()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits debug information for the given AST node
void emit_debug(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

  fprintf(stdout, "# Node Type: %s\n", ASTtype_to_string(node->nodetype));
} // end of emit_debug()
