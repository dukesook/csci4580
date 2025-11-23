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
static void emit_expression_statement(ASTnode*, FILE*);
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
static void emit_dereference_if_variable(ASTnode*, FILE*);
static void emit_arg_list(ASTnode*, FILE*);
static void emit_argument_expression(ASTnode*, FILE*);
static void emit_argument_load(ASTnode*, FILE*, int arg_index);
static void emit_return(ASTnode*, FILE*);
static void emit_break(ASTnode*, FILE*);
static void emit_continue(ASTnode*, FILE*);

// Prototypes - Helpers
static char* create_label();
static void assert_nodetype(ASTnode* node, enum ASTtype expected_type);
static void assert_expression_family(ASTnode* node);
static int count_arguments(ASTnode* argument);
static void set_while_labels(ASTnode*, char* start_label, char* end_label);
static void link_return_to_function(ASTnode*, SymbTab* );

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


  switch (p->nodetype) {
    case A_DEC_LIST:
      emit_ast(p->s2, fp);
      emit_ast(p->s1, fp);
      break;
    case A_VARDEC:
    case A_COMPOUND:
    case A_STMT_LIST:
    case A_VOID_PARAM:
    case A_SELECTION_BODY:
    case A_ARG_LIST:
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
    case A_EXPRESSION_STATEMENT:
      emit_expression_statement(p, fp);
      break;
    case A_EXPRESSION:
      emit_expression(p, fp);
      break;
    case A_NUMBER:
    case A_BOOLEAN:
      emit_constant(p, fp);
      break;
    case A_SELECTION_STATEMENT:
      emit_if(p, fp);
      break;
    case A_ITERATION_STATEMENT:
      emit_while(p, fp);
      break;
    case A_RETURN:
      emit_return(p, fp);
      break;
    case A_BREAK:
      emit_break(p, fp);
      break;
    case A_CONTINUE:
      emit_continue(p, fp);
      break;
    case A_PROTOTYPE:
      // Do nothing! Don't even emit children!
      break;
    case A_ARGUMENT:
    default:
      printf("emit_ast(): ERROR! Unhandled node type %s\n", type);
      exit(1);
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

void emit_while(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_ITERATION_STATEMENT);
  
  char* while_label = create_label();
  char* end_label = create_label();
  char s[256];

  set_while_labels(p, while_label, end_label);

  // Hard code for now:
// _L0:			# # WHILE TOP target
  fprintf(fp, "%s:  # While loop\n", while_label);

  // Emit condition
  emit_ast(p->s1, fp);
  emit_dereference_if_variable(p->s1, fp);

  // if false, jump to end label
  sprintf(s, "beq $a0, $0, %s", end_label);
  emit_line(fp, s, "# if expression is 0, jump to end of while");

  // While loop Body
  emit_ast(p->s2, fp); // Emit the body of the while statement
  emit_dereference_if_variable(p->s2, fp);

  // Jump to While Start
  sprintf(s, "j %s", while_label);
  emit_line(fp, s, "# Jump to while start");

  // End Label
  fprintf(fp, "%s:\n", end_label);

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
    int size = node->value * WSIZE; // size in bytes
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

  assert_nodetype(p, A_FUNCTIONDEC);

  link_return_to_function(p, p->symbol);

  emit_comment(fp, "Function Declaration");

  char s[256];
  int size = p->symbol->offset * WSIZE; // size in bytes
  
  emit(fp, p->name, "", "Start of function");
  fprintf(fp, "\n");
  sprintf(s, "subu $a0, $sp, %d", size);
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
  } else {
    emit_line(fp, "jr $ra", "Return from function");
  }

}

// PRE:
// POST:
void emit_expression_statement(ASTnode* p, FILE* fp) {
  
  assert_nodetype(p, A_EXPRESSION_STATEMENT);
  assert_expression_family(p->s1);

  emit_ast(p->s1, fp);
  emit_dereference_if_variable(p->s1, fp);
}

// PRE: ASTnode pointer p, file pointer fp
// POST: MIPS Code so that $a0 has the return value
void emit_expression(ASTnode* node, FILE* fp) {

  assert_nodetype(node, A_EXPRESSION);

  if (node->operator == A_NOT) {
    emit_ast(node->s1, fp); // $a0 has the result of the left hand side expression
    emit_dereference_if_variable(node->s1, fp);
    return;
  }

  char* type = ASTtype_to_string(node->nodetype);
  char line[256];
  int offset = 0;

  
  // Left Hand Side
  emit_ast(node->s1, fp); // $a0 has the result of the left hand side expression
  emit_dereference_if_variable(node->s1, fp);
  offset = node->symbol->offset * WSIZE;
  sprintf(line, "sw $a0, %d($sp)", offset);
  emit_line(fp, line, "expression store LHS temporarily");

  // Right Hand Side
  emit_ast(node->s2, fp); // $a0 has the result of the left hand side expression
  emit_dereference_if_variable(node->s2, fp);
  emit_line(fp, "move $a1, $a0", "Move RHS into $a1");

  offset = node->symbol->offset * WSIZE;
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
    case A_LT:
      emit_line(fp, "slt $a0, $a0, $a1", "Expression LT");
      break;
    case A_GT:
      emit_line(fp, "slt $a0, $a1, $a0", "Expression GT");
      break;
    case A_LE:
      emit_line(fp, "add $a1, $a1, 1", "Expression LE adjust");
      emit_line(fp, "slt $a0, $a0, $a1", "Expression LE");
      break;
    case A_GE:
      emit_line(fp, "add $a0, $a0, 1", "Expression GE adjust");
      emit_line(fp, "slt $a0, $a1, $a0", "Expression GE");
      break;
    case A_EQ:
      emit_line(fp, "slt $t2, $a0, $a1", "Expression EQ part 1");
      emit_line(fp, "slt $t3, $a1, $a0", "Expression EQ part 2");
      emit_line(fp, "nor $a0, $t2, $t3", "Expression EQ final");
      emit_line(fp, "andi $a0, 1", "Expression EQ result");
      break;
    case A_NE:
      emit_line(fp, "slt $t2, $a0, $a1", "Expression NE part 1");
      emit_line(fp, "slt $t3, $a1, $a0", "Expression NE part 2");
      emit_line(fp, "or $a0, $t2, $t3", "Expression NE final");
      break;
      case A_AND:
      case A_OR:
      // emit nothing?
      break;
    case A_NOT:
        // handled above
    default:
      printf("emit_expression(): unhandled operator: %s\n", operator);
      exit(1);
  }

}

// PRE: 
// POST: $a0 will have the return value
void emit_call(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_FUNCTION_CALL);

  emit_comment(fp, "Function Call");

  // Emit arguments
  emit_arg_list(p->s1, fp); // Arguments (if any)
  // Argument expressions are evaluated and stored in $t0, $t1, etc.

  // Call function
  char s[256];
  sprintf(s, "jal %s", p->name);
  emit_line(fp, s, "Function call jump and link");

} // end of emit_call()

// PRE: ASTnode pointer p, file pointer fp
// POST: Emits MIPS code for assignment statements
void emit_assignment_statement(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_ASSIGNMENT_STATEMENT);
  int rhs_offset = p->symbol->offset * WSIZE;

  char s[256];

  fprintf(fp, "\n");
  emit_comment(fp, "Assignment Statement");

  // ---- Right Hand Side ----
  // emit_ast(p->s2, fp); // compute RHS → $a0
  emit_ast(p->s2, fp); // compute RHS → $a0
  emit_dereference_if_variable(p->s2, fp); // ensure $a0 has the value of the RHS
  sprintf(s, "sw $a0, %d($sp)", rhs_offset);
  emit_line(fp, s, "Assign store RHS temporarily");
  
  // ---- Left Hand Side ----
  emit_ast(p->s1, fp);

  // Get RHS value
  sprintf(s, "lw $a1, %d($sp)", rhs_offset);
  emit_line(fp, s, "Assign get RHS temporarily");

  // Assign RHS value to variable
  emit_line(fp, "sw $a1, ($a0)", "Assign place RHS into memory");

  fprintf(fp, "\n");

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
  bool is_array = (p->s1) ? true : false; // array vs scalar
  bool is_global_variable = (p->symbol->level == 0) ? true : false;

  // Get Array Index
  if (is_array) {

    emit_ast(p->s1, fp); // $a0 has the result of the index expression
    emit_dereference_if_variable(p->s1, fp); // ensure $a0 has the value of the index expression

    emit_line(fp, "move $a1, $a0", "Copy index into $a1");
    emit_line(fp, "sll $a1, $a1, 2", "Multiply index by 4 (word size)");

  }


  // Load Variable Address
  if (is_global_variable) {
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

  // Array Address + Offset
  if (is_array) {
    if (p->symbol->SubType == SYM_ARRAY_PARAMETER) {
      emit_line(fp, "lw, $a0, ($a0)", "Load address of array parameter");
    }
    emit_line(fp, "add $a0, $a0, $a1", "Compute address of array element");
  }

}

// PRE:
// POST:
void emit_parameter(ASTnode* p, FILE* fp) {
  
  assert_nodetype(p, A_PARAM);

  int offset = p->symbol->offset * WSIZE; // offset in bytes
  int param_index = p->symbol->offset - 2; // 2 is the size of the function
  char s[256];

  sprintf(s, "sw $t%d, %d($sp)", param_index, offset);
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

// PRE:
// POST:
void emit_dereference_if_variable(ASTnode* node, FILE* fp) {
  if (!node) {
    return;
  } else if ( node->nodetype != A_VARIABLE) {
    return;
  }
  // emit_ast(node, fp); // $a0 has the result

  // Load variable value into $a0
  emit_line(fp, "lw $a0, ($a0)", "# load variable value");

}

// PRE:
// POST:
void emit_if(ASTnode* p, FILE* fp) {

  /*
  A_SELECTION_STATEMENT:
    s1 = EXPRESSION (condition)
    s2 = A_SELECTION_BODY
      s1 = THEN branch statement
      s2 = ELSE branch statement (if any)
  */

  assert_nodetype(p, A_SELECTION_STATEMENT);

  ASTnode* body_node = p->s2;
  assert_nodetype(body_node, A_SELECTION_BODY);

  char s[256];
  char* else_label = create_label();
  char* if_label = create_label();

  // Emit condition
  emit_ast(p->s1, fp); // $a0 has the condition result
  emit_dereference_if_variable(p->s1, fp); // Emit the body of the if statement
  
  // if false, jump to else label
  sprintf(s, "beq $a0, $0, %s", else_label);
  emit_line(fp, s, "# if expression is 0, jump to else");

  // if true
  emit_ast(body_node->s1, fp); // Emit the body of the if statement
  emit_dereference_if_variable(body_node->s1, fp); // Emit the body of the if statement
  sprintf(s, "j %s", if_label);
  emit_line(fp, s, "# Jump to end of if statement");

  // else label
  sprintf(s, "%s:", else_label);
  emit_line(fp, s, "# ELSE label");
  emit_ast(body_node->s2, fp); // Emit the body of the else statement (if any)
  emit_dereference_if_variable(body_node->s2, fp); // Emit the body of the else statement (if any)

  // end if label
  sprintf(s, "%s:", if_label);
  emit_line(fp, s, "# End of IF statement");

} // end of emit_if()

// PRE:
// POST:
void emit_arg_list(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_ARG_LIST);

  if (p->s1) {
    emit_argument_expression(p->s1, fp); // First argument
    emit_argument_load(p->s1, fp, 0); // Load arguments into $t# registers
  }

  int arg_count = count_arguments(p->s1);
  int offset = 0;
  for (int i = 0; i < arg_count; i++) {
    offset = (arg_count - i + 1) * WSIZE;
    char s[256];
    // sprintf(s, "lw $a0, %d($sp)", offset);
    // emit_line(fp, s, "Load argument into $a register");
    // sprintf(s, "move $t%d, $a0", i);
    // emit_line(fp, s, "Move argument into temp variable");

  }

} // end of emit_arg_list()

// PRE:
// POST: Evaluate each argument expression and push it onto the stack
void emit_argument_expression(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_ARGUMENT);

  emit_ast(p->s1, fp); // Evaluate the argument expression
  emit_dereference_if_variable(p->s1, fp); // Ensure $a0

  char s[256];
  sprintf(s, "sw $a0, %d($sp)", p->symbol->offset * WSIZE);
  emit_line(fp, s, "Push argument onto stack");

  if (p->s2) {
    emit_argument_expression(p->s2, fp); // Next argument (if any)
  }

} // end of emit_argument_expression()

// PRE:
// POST:
void emit_argument_load(ASTnode* p, FILE* fp, int arg_index) {

  assert_nodetype(p, A_ARGUMENT);

  char s[256];
  sprintf(s, "lw $a0, %d($sp)", p->symbol->offset * WSIZE);
  emit_line(fp, s, "Load argument into $a register");
  sprintf(s, "move $t%d, $a0", arg_index);
  emit_line(fp, s, "Move argument into temp variable");

  if (p->s2) {
    emit_argument_load(p->s2, fp, arg_index + 1); // Next argument (if any)
  }

} // end of emit_argument_load()

// PRE:
// POST:
void emit_return(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_RETURN);

  if (p->s1) {
    // Return expression
    emit_ast(p->s1, fp); // Evaluate return expression
    emit_dereference_if_variable(p->s1, fp); // Ensure $a0 has the return value
  } else {
    // Void return
    emit_line(fp, "li $a0, 0", "Void return value 0");
  }

  emit_line(fp, "lw $ra, 4($sp)", "restore old environment RA");
  emit_line(fp, "lw $sp, ($sp)", "Return from function store SP");

  char* function_name = p->symbol->name;
  if (strcmp(function_name, "main") == 0) {
    // Main function return

    emit_line(fp, "li $v0, 10", "Exit we are done");
    emit_line(fp, "syscall", "EXIT everything");
  } else {
    emit_line(fp, "jr $ra", "Return from function");
  }

  // Hardcode for now:



}

// PRE:
// POST:
void emit_break(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_BREAK);

  char s[256];
  sprintf(s, "j %s", p->label);
  emit_line(fp, s, "BREAK Statement line jump inside of while");

} // end of emit_break()

void emit_continue(ASTnode* p, FILE* fp) {

  assert_nodetype(p, A_CONTINUE);

  char s[256];
  sprintf(s, "j %s", p->label);
  emit_line(fp, s, "CONTINUE Statement line jump inside of while");

} // end of emit_continue()

// Prototypes - Helpers


// PRE: None
// POST: Creates and returns a unique label string
char* create_label() {
  static int label_count = 0;
  char label[64];
  sprintf(label, "_L%d", label_count++);
  return strdup(label);
} // end of create_label()

int count_arguments(ASTnode* argument) {

  if (!argument) {
    return 0;
  }
  
  int count = 0;

  if (argument->s2) {
    count = 1 + count_arguments(argument->s2);  
  } else {
    return 1;
  }

  return count;
} // end of count_arguments()

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

void assert_expression_family(ASTnode* node) {
  if (!node) {
    fprintf(stderr, "Error: Expected an expression node but got NULL\n");
    exit(1);
  }

  switch (node->nodetype) {
    case A_EXPRESSION:
    case A_VARIABLE:
    case A_NUMBER:
    case A_BOOLEAN:
    case A_FUNCTION_CALL:
      return; // Valid expression family node types
    default:
      fprintf(stderr, "Error: Expected an expression node but got %s\n",
              ASTtype_to_string(node->nodetype));
      exit(1);
  }

}

// PRE: 
// POST: Each A_BREAK & A_CONTINUE labels are set appropriately
void set_while_labels(ASTnode* p, char* start_label, char* end_label) {
  
  if (!p) {
    return;
  }

  if (p->nodetype == A_BREAK) {
    p->label = end_label;
  } else if (p->nodetype == A_CONTINUE) {
    p->label = start_label;
  }

  set_while_labels(p->s1, start_label, end_label);
  set_while_labels(p->s2, start_label, end_label);
}

// PRE:
// POST: Links each A_RETURN node to its function declaration symbol table entry
void link_return_to_function(ASTnode* node, SymbTab* function_delcaration) {
  if (!node) {
    return;
  }

  if (node->nodetype == A_RETURN) {
    node->symbol = function_delcaration;
  }

  link_return_to_function(node->s1, function_delcaration);
  link_return_to_function(node->s2, function_delcaration);

}