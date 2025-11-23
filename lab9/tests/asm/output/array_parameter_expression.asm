# MIPS code generated from AST

.data

.align 2
y: .space 400  # global variable

.text

.globl main
# Function Declaration
foo:			# Start of function

	subu $a0, $sp, 32		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable

# Assignment Statement
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 28($sp)		# Assign store RHS temporarily
	li $a0, 10		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 44		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value

# Assignment Statement
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 28($sp)		# Assign store RHS temporarily
	li $a0, 10		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 37		# Expression is a constant
	sw $a0, 32($sp)		# expression store LHS temporarily
	li $a0, 92		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, y		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 40($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
