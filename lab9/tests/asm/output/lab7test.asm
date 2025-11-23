# MIPS code generated from AST

.data

.align 2
y: .space 4  # global variable
Z: .space 400  # global variable
z: .space 4  # global variable

.text

.globl main
# Function Declaration
f:			# Start of function

	subu $a0, $sp, 84		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable

# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 76($sp)		# expression store LHS temporarily
# Function Call
	li $a0, 5		# Expression is a constant
	sw $a0, 68($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 64($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 64($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 68($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 72($sp)		# Push argument onto stack
	lw $a0, 72($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal f		# Function call jump and link
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 76($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 80($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 60($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 60($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 80($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 76($sp)		# expression store LHS temporarily
# Function Call
	li $a0, 5		# Expression is a constant
	sw $a0, 68($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 64($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 64($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 68($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 72($sp)		# Push argument onto stack
	lw $a0, 72($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal f		# Function call jump and link
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 76($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 80($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 60($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 60($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 80($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 56		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	sw $t1, 12($sp)		# Load formal parameter into temp variable
# WRITE statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 24($sp)		# expression store LHS temporarily
	la $a0, z		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 28($sp)		# expression store LHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 32($sp)		# Push argument onto stack
	lw $a0, 32($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal f		# Function call jump and link
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 44($sp)		# expression store LHS temporarily
	la $a0, z		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 44($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 48($sp)		# expression store LHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 52($sp)		# Push argument onto stack
	lw $a0, 52($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal f		# Function call jump and link
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
