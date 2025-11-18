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

// Prototypes
static void emit_ast(ASTnode*, FILE*);
static void emit(FILE*, char* label, char* command, char* comment);
static void emit_line(FILE*, char* line, char* comment);
static void emit_traverse_ast(ASTnode*, FILE*, EmitFunction);
static void emit_global_variable(ASTnode*, FILE*);
static void emit_string(ASTnode*, FILE*);
static void emit_function_declaration(ASTnode*, FILE*);
static void emit_expression(ASTnode*, FILE*);
static void emit_assignment_statement(ASTnode*, FILE*);
static void emit_read(ASTnode*, FILE*);
static void emit_write(ASTnode*, FILE*);
static void emit_variable(ASTnode*, FILE*);
static void emit_comment(FILE* fp, char* comment);
static void emit_call(ASTnode*, FILE*);
static void emit_if(ASTnode*, FILE*);
static void emit_while(ASTnode*, FILE*);
static void emit_parameter(ASTnode*, FILE*);
static void emit_constant(ASTnode*, FILE*);

// Prototypes - Helpers
static char* create_label();
static char* create_temp_variable();
static void assert_nodetype(ASTnode* node, enum ASTtype expected_type);

// PRE: ASTnode pointer p, file pointer fp
// POST: All MIPS code directly and through helper functions
//       prints in the file via the file pointer.
void EMIT(ASTnode* root, FILE* fp) {

  fprintf(fp, "# MIPS code generated from AST\n");
  
  // Data
  fprintf(fp, "\n.data\n");
  // emit_traverse_ast(root, fp, emit_string);
  emit_string(root, fp);
  
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

  if (p->nodetype == A_STMT_LIST) {
    printf("# Statement List\n");
  }

  switch (p->nodetype) {
    case A_DEC_LIST:
    case A_VARDEC:
    case A_COMPOUND:
    case A_STMT_LIST:
    case A_VOID_PARAM:
    case A_EXPRESSION_STATEMENT:
      emit_ast(p->s1, fp);
      emit_ast(p->s2, fp);
      break;
    case A_FUNCTIONDEC:
      emit_function_declaration(p, fp);
      break;
    case A_VARIABLE:
      emit_variable(p, fp);
      break;
    case A_WRITE:
      emit_write(p, fp);
      break;
    case A_READ:
      emit_read(p, fp);
      break;
    case A_ASSIGNMENT_STATEMENT:
      emit_assignment_statement(p, fp);
      break;
    case A_FUNCTION_CALL:
      emit_call(p, fp);
      break;
    case A_PARAM:
      emit_parameter(p, fp);
      break;
    case A_EXPRESSION:
      emit_expression(p, fp);
      break;
    case A_NUMBER:
    case A_BOOLEAN:
      emit_constant(p, fp);
      break;
    case A_PROTOTYPE:
    case A_ARG_LIST:
    case A_ARGUMENT:
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

void emit_if(ASTnode* p, FILE* fp) {
  // TODO - implement emit_if()
  // Explained in 2nd half of lecture on November 13
} // end of emit_if()

void emit_while(ASTnode* p, FILE* fp) {
  // TODO - implement emit_while()
  // Explained in 2nd half of lecture on November 13
} // end of emit_while()

// PRE: ASTnode pointer p, file pointer fp, function pointer for traversal
// POST: Traverses the AST and applies the given function to each node
void emit_traverse_ast(ASTnode* node, FILE* fp, EmitFunction function) {
  if (!node) {
    return;
  }
  
  // Traverse children
  emit_traverse_ast(node->s2, fp, function);
  emit_traverse_ast(node->s1, fp, function);

  // Process current node
  function(node, fp);

} // end of emit_traverse_ast()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits global variable declarations in MIPS code
void emit_global_variable(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  }

  if (!node->symbol) {
    return;// No symbol table entry
  } else if (node->symbol->level != 0) {
    return;// Not a global variable
  }

  if (node->nodetype == A_VARDEC) {
    char* type = ASTtype_to_string(node->nodetype);
    printf("%s", type);
    int size = node->value * WSIZE; // size in bytes
    printf("\n");


    fprintf(fp, "%s: .space %d  # global variable\n", node->name, size);
  }

  return;

} // end of emit_global_variable()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits string literals in MIPS code
void emit_string(ASTnode* node, FILE* fp) {
  
  if (!node) {
    return;
  }

  if (node->nodetype == A_WRITE && node->name)  {
    node->label = create_label();
    fprintf(fp, "%s:  .asciiz %s\n", node->label, node->name);
  }

  emit_string(node->s1, fp);
  emit_string(node->s2, fp);

  return;

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

  emit_ast(p->s1, fp); // Call for parameters (if any)
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
// POST: MIPS Code so that $a0 has the return value
void emit_expression(ASTnode* node, FILE* fp) {

  assert_nodetype(node, A_EXPRESSION);

  char* type = ASTtype_to_string(node->nodetype);
  char line[256];
  int offset = 0;

  // Left Hand Side
  emit_ast(node->s1, fp); // $a0 has the result
  offset = node->s1->symbol->offset * WSIZE;
  sprintf(line, "sw $a0, %d($sp)", offset);
  emit_line(fp, line, "expression store LHS temporarily");

  // Right Hand Side
  emit_ast(node->s2, fp); // $a0 has the result
  emit_line(fp, "move $a1, $a0", "Move RHS into $a1");

  offset = node->s2->symbol->offset * WSIZE;
  sprintf(line, "lw $a0, %d($sp)", offset);
  emit_line(fp, line, "expression restore LHS from memory");

  const char* operator = operator_to_string(node->operator);
  switch(node->operator) {
    case A_PLUS:
      emit_line(fp, "add $a0, $a0, $a1", "Expression PLUS");
      break;
    case A_MINUS:
      emit_line(fp, "sub $a0, $a0, $a1", "Expression MINUS");
      break;
    case A_TIMES:
      emit_line(fp, "mult $a0, $a1", "Expression TIMES");
      emit_line(fp, "mflo $a0", "EXPR MULT");
      break;
      case A_DIVIDE:
      emit_line(fp, "div $a0, $a1", "Expression DIVIDE");
      emit_line(fp, "mflo $a0", "EXPR DIV");
      break;
    default:
      printf("emit_expression(): unhandled operator\n");
      exit(1);
  }

}

// PRE: 
// POST: $a0 will have the return value
void emit_call(ASTnode* p, FILE* fp) {

} // end of emit_call()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for assignment statements
void emit_assignment_statement(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_ASSIGNMENT_STATEMENT);
  int rhs_offset = p->s2->symbol->offset * WSIZE;

  char s[256];

  fprintf(fp, "\n");
  emit_comment(fp, "ASSIGNMENT statement");

  // ---- Right Hand Side ----
  emit_ast(p->s2, fp); // compute RHS → $a0
  sprintf(s, "sw $a0, %d($sp)", rhs_offset);
  emit_line(fp, s, "Assign store RHS temporarily");
  
  // ---- Left Hand Side ----
  // Get Variable Address
  if (p->s1->symbol->level == 0) {
    // Global Varible
    sprintf(s, "la $a0, %s", p->s1->name); // for global variable
    emit_line(fp, s, "EMIT Var global variable");
  } else {
    // Local Variable
    emit_line(fp, "move $a0, $sp", "VAR local make a copy of stackpointer");

    int offset = p->s1->symbol->offset * WSIZE;
    sprintf(s, "addi $a0, $a0, %d", offset);
    emit_line(fp, s, "EMIT Var local variable");
  }

  // Get RHS value
  sprintf(s, "lw $a1, %d($sp)", rhs_offset);
  emit_line(fp, s, "Assign get RHS temporarily");

  // Assign RHS value to variable
  emit_line(fp, "sw $a1, ($a0)", "Assign place RHS into memory");

  fprintf(fp, "\n");
  // y = 5;
	// li $a0, 5		# expression is a constant
	// sw $a0 8($sp)		# Assign store RHS temporarily
	// la $a0, y		# EMIT Var global variable
	// lw $a1 8($sp)		# Assign get RHS temporarily
	// sw $a1 ($a0)		# Assign place RHS into memory

}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for read statements
void emit_read(ASTnode* p, FILE* fp) {
  emit_comment(fp, "READ statement");
  emit_variable(p->s1, fp); // $a0 is the location
  emit_line(fp, "li $v0, 5", "5 in $v0 means: Read an integer from the user");
  emit_line(fp, "syscall", "READ INTEGER");
  emit_line(fp, "sw $v0, ($a0)", "Store the read value into the variable");
  fprintf(fp, "\n");
  return;
}

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for write statements
void emit_write(ASTnode* p, FILE* fp) {
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
    emit_ast(p->s1, fp);
    if (p->s1->nodetype == A_VARIABLE) {
      // Load variable value into $a0
      emit_line(fp, "lw $a0, ($a0)", "# load variable value");
    } else {
      // $a0 already has the expression result
    }
    emit_line(fp, "li $v0, 1", "# print the number");
    emit_line(fp, "syscall", "#system call for print number");
    fprintf(fp, "\n\n");
  }

  fprintf(fp, "\n");
  fprintf(fp, "\n");


} // end of emit_write()

// PRE: Pointer to A_VARIABLE
// POST: Variable's address in $a0
void emit_variable(ASTnode* p, FILE* fp) {
// Variables are either global or local.
//   1. global - the start point is where the label is located
//   2. local - it is stack pointer + offset (WSIZE).
// Variables are either array or scalar.
//    For arrays, add internal offset.

  assert_nodetype(p, A_VARIABLE);

  char s[256];

  if (p->symbol->level == 0) {
    // Global variable
    // load address of global variable into $a0
    sprintf(s, "la $a0, %s", p->name);
    emit_line(fp, s, "EMIT Var global variable");
  } else {
    // Local variable
    emit_line(fp, "move $a0, $sp", "VAR local make a copy of stackpointer");
    int offset = p->symbol->offset * WSIZE;
    sprintf(s, "addi $a0, $a0, %d", offset);
    emit_line(fp, s, "EMIT Var local variable");
  }

}

// PRE:
// POST:
void emit_parameter(ASTnode* p, FILE* fp) {
  if (!p) {
    return;
  }

  int offset = p->symbol->offset * WSIZE; // offset in bytes
  char s[256];
  char* temp_name = create_temp_variable();
  sprintf(s, "sw $%s, %d($sp)", temp_name, offset);
  emit_line(fp, s, "Load formal parameter into temp variable");

  emit_ast(p->s1, fp); // Next parameter (if any)

} // end of emit_parameter()

// PRE: file pointer fp, char pointer comment
// POST: Emits a comment line in MIPS code
void emit_comment(FILE* fp, char* comment) {
  fprintf(fp, "# %s\n", comment);
}

// PRE:
// POST:
void emit_constant(ASTnode* p, FILE* fp) {
  if (!p) {
    return;
  }

  char s[256];
  sprintf(s, "li $a0, %d", p->value);
  emit_line(fp, s, "Expression is a constant");
}


// Prototypes - Helpers


// PRE: None
// POST: Creates and returns a unique label string
char* create_label() {
  static int label_count = 0;
  char label[64];
  sprintf(label, "_L%d", label_count++);
  return strdup(label);
} // end of create_label()

// PRE:
// POST:
char* create_temp_variable() {
  static int temp_count = 0;
  char temp[64];
  sprintf(temp, "t%d", temp_count++);
  return strdup(temp);
} // end of create_temp_variable()

void assert_nodetype(ASTnode* node, enum ASTtype expected_type) {
  if (!node) {
    fprintf(stderr, "Error: Expected node type %s but got NULL\n",
            ASTtype_to_string(expected_type));
    exit(1);
  } else if (node->nodetype != expected_type) {
    fprintf(stderr, "Error: Expected node type %s but got %s\n",
            ASTtype_to_string(expected_type), ASTtype_to_string(node->nodetype));
    exit(1);
  }
}