# MIPS code generated from AST

.data

.align 2
g: .space 20  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 216		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	sw $a0, 212($sp)		# Push argument onto stack
	li $a0, 4		# Expression is a constant
	sw $a0, 208($sp)		# Push argument onto stack
	lw $a0, 212($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 208($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal foo		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
# Function Declaration
foo:			# Start of function

	subu $a0, $sp, 32		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	sw $t1, 12($sp)		# Load formal parameter into temp variable
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# Push argument onto stack
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# Push argument onto stack
	lw $a0, 20($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 16($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal foo		# Function call jump and link
# Function Call
	la $a0, g		# EMIT Var global variable
	sw $a0, 28($sp)		# Push argument onto stack
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 24($sp)		# Push argument onto stack
	lw $a0, 28($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 24($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal foo		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
