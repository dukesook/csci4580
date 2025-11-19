# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 55		# Expression is a constant
	beq $a0, $0, _L0		# # if expression is 0, jump to else
	li $a0, 88		# expression is a constant
	j _L1		# # Jump to end of if statement
	_L0:		# # ELSE label
	li $a0, 100		# expression is a constant
	_L1:		# # End of IF statement
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
