# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
foo:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
# Function Call
	li $a0, 50		# Expression is a constant
	sw $a0, 12($sp)		# Push argument onto stack
	lw $a0, 12($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal foo		# Function call jump and link
	sw $a0, 16($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
