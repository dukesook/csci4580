# MIPS code generated from AST

.data

.align 2
x: .space 4  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 160		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable

# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 20($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 24($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 24($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	sw $a0, 28($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 32($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 36($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 36($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 44($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 44($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 48($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 52($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 52($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	sw $a0, 60($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 60($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 64($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 64($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 68($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 68($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 72($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 72($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	sw $a0, 76($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 76($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 80($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 80($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 84($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 84($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 88($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 88($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 92($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 92($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 96($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 96($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 100($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 100($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 104($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 104($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	sw $a0, 108($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 108($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 112($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 112($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 116($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 116($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 120($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 120($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	sw $a0, 124($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 124($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 128($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 128($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 132($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 132($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 136($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 136($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 140($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 140($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 144($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 144($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 148($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 148($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 152($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 152($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	sw $a0, 156($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 156($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
