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
	li $a0, 0		# Void return value 0
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	jr $ra		# Return from function
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
