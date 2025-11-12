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
  emit_ast(root, fp);


} // end of EMIT()

// PRE: Pointer to astnode
// POST: Main driver for walking out AST Tree to produce
//     MIPS code by calling appropriate helper functions
void emit_ast(ASTnode* p, FILE* fp) {

  if (!p) {
    return;
  }

  char* type = ASTtype_to_string(p->nodetype);

  switch (p->nodetype) {
    case A_DEC_LIST:
    case A_VARDEC:
    case A_COMPOUND:
    case A_STMT_LIST:
    case A_VOID_PARAM:
    case A_VARIABLE:
      emit_ast(p->s1, fp);
      emit_ast(p->s2, fp);
      break;
    case A_FUNCTIONDEC:
      emit_function_declaration(p, fp);
      break;
    case A_WRITE:
      emit_write(p, fp);
      break;
    case A_READ:
      emit_read(p, fp);
      break;
    case A_EXPRESSION_STATEMENT:
      emit_expression(p, fp);
      break;
    case A_PROTOTYPE:
    case A_FUNCTION_CALL:
    case A_ARG_LIST:
    case A_ARGUMENT:
    case A_NUMBER:
    case A_BOOLEAN:
    case A_EXPRESSION:
    case A_PARAM:
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



} // end of emit_ast()

// PRE: file pointer fp, char pointers label, command, comment
// POST: Emits a MIPS command with optional label and comment
void emit(FILE* fp, char* label, char* command, char* comment) {
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
} // of emit()

// PRE: file pointer fp, char pointer line, char pointer comment
// POST: Emits a line of MIPS code with an optional comment
void emit_line(FILE* fp, char* line, char* comment) {
  emit(fp, "", line, comment);
}

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

  // Run callback() if provided
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

  node->label = emit_create_label();
  fprintf(fp, "%s:  .asciiz %s\n", node->label, node->name);

  return NULL;

} // end of emit_string()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for function declarations
void emit_function_declaration(ASTnode* p, FILE* fp) {

  emit_comment(fp, "Function Declaration");

  char s[256];
  int size = p->symbol->offset * WSIZE; // size in bytes
  sprintf(s, "subu $a0, $sp, %d", size);

  emit(fp, p->name, "", "Start of function");
  fprintf(fp, "\n");
  emit_line(fp, s, "adjust the stack for function setup");
  emit_line(fp, "sw $sp, ($a0)", "remember old SP");
  emit_line(fp, "sw $ra, 4($a0)", "remember current Return address");
  emit_line(fp, "move $sp, $a0", "adjust the stack pointer");
  fprintf(fp, "\n");
  fprintf(fp, "\n");

  emit_ast(p->s2, fp); // Call for compound statement (function body)

  emit_comment(fp, "Function Return");

  emit_line(fp, "li $a0, 0", "restore RA");
  emit_line(fp, "lw $ra, 4($sp)", "restore old environment RA");
  emit_line(fp, "lw $sp, ($sp)", "Return from function store SP");
  fprintf(fp, "\n");

  if (strcmp(p->name, "main") == 0) {
    emit_comment(fp, "Exit from main function");
    emit_line(fp, "li $v0, 10", "Exit from Main we are done");
    emit_line(fp, "syscall", "EXIT everything");
    // li $v0, 10		# Exit from Main we are done
	  // syscall			# EXIT everything
  } else {
    // TODO! normal function return;
    printf("# TODO! normal function return;\n");
    // exit(1);
  }

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for expressions
CallbackFn emit_expression(ASTnode* node, FILE* fp) {

  if (!node) {
    return NULL;
  }

  char* type = ASTtype_to_string(node->nodetype);
  char line[256];

  switch (node->nodetype) {
    case A_NUMBER:
    case A_BOOLEAN:
    sprintf(line, "li $a0, %d", node->value);
    emit_line(fp, line, "Expression is a constant");
      return NULL;
    case A_VARIABLE:
      emit_variable(node, fp); // $a0 is the location
      emit_line(fp, "lw $a0, ($a0)", "Expression is a variable, get value");
      return NULL;
    case A_FUNCTION_CALL:
    case A_EXPRESSION:
    default:
      printf("emit_expression(): unhandled nodetype: %s\n", type);
      // exit(1);
  } // end of switch

  return NULL;

}


// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for read statements
CallbackFn emit_read(ASTnode* p, FILE* fp) {
  emit_comment(fp, "READ statement");
  emit_variable(p->s1, fp); // $a0 is the location
  emit_line(fp, "li $v0, 5", "5 in $v0 means: Read an integer from the user");
  emit_line(fp, "syscall", "READ INTEGER");
  emit_line(fp, "sw $v0, ($a0)", "Store the read value into the variable");
  fprintf(fp, "\n");
  return NULL;
}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for write statements
CallbackFn emit_write(ASTnode* p, FILE* fp) {
  // There are type types of write:
  //    1. String
  //    2. Expression

  emit_comment(fp, "WRITE statement");

  if (p->name) {
    // String
    char s[100];
    sprintf(s, "la $a0, %s", p->label);
    emit_line(fp, "li $v0, 4", "# print a string");
    emit_line(fp, s, "# print fetch string location");
    emit_line(fp, "syscall", "Perform a write string");
  } else {
    // Expression
    emit_expression(p->s1, fp);
    emit_line(fp, "li $v0, 1", "# print the number");
    emit_line(fp, "syscall", "#system call for print number");
    fprintf(fp, "\n\n");
  }

  fprintf(fp, "\n");
  fprintf(fp, "\n");

  return NULL;

} // end of emit_write()

// PRE: ASTnode pointer p, file pointer fp
// POST: $a0 will be the memory location of the varible.
CallbackFn emit_variable(ASTnode* p, FILE* fp) {
// Variables are either global or local.
//   1. global - the start point is where the label is located
//   2. local - it is stack pointer + offset (WSIZE).
// Variables are either array or scalar.
//    For arrays, add internal offset.

  if (!p) {
    return NULL;
  } else if (!p->symbol) {
    return NULL;
  }

  char s[256];

  if (p->symbol->level == 0) {
    // Global variable
    sprintf(s, "la $a0, %s", p->name); // load address of global variable into $a0
    emit_line(fp, s, "EMIT Var global variable");
  } else {
    // Local variable
    printf("TODO - emit_variable() for local variable\n");
    exit(1);
  }

}

// PRE: None
// POST: Creates and returns a unique label string
char* emit_create_label() {
  static int label_count = 0;
  char label[64];
  sprintf(label, "_L%d", label_count++);
  return strdup(label);
} // end of emit_create_label()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits debug information for the given AST node
void emit_debug(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

  fprintf(stdout, "# Node Type: %s\n", ASTtype_to_string(node->nodetype));
} // end of emit_debug()

// PRE: file pointer fp, char pointer comment
// POST: Emits a comment line in MIPS code
void emit_comment(FILE* fp, char* comment) {
  fprintf(fp, "# %s\n", comment);
}