# MIPS code generated from AST

.data
_L0:  .asciiz "true\n"
_L1:  .asciiz "false\n"

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 0		# Expression is a constant
	beq $a0, $0, _L2		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


	j _L3		# # Jump to end of if statement
	_L2:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


	_L3:		# # End of IF statement
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
