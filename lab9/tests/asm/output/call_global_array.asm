# MIPS code generated from AST

.data

.align 2
x: .space 400  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 99		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
