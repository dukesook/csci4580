# MIPS code generated from AST

.data
_L0:  .asciiz "enter X"
_L1:  .asciiz " x is "

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


# READ statement
