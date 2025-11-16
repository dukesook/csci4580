# MIPS code generated from AST

.data
_L0:  .asciiz "hello world"
_L1:  .asciiz "\n"

.align 2
A: .space 400  # global variable
x: .space 4  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 16		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $a0, 42		# Expression is a constant
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
