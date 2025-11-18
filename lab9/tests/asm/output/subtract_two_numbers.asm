# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 57		# Expression is a constant
	sw $a0, 8($sp)		# expression store LHS temporarily
	li $a0, 29		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 8($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
