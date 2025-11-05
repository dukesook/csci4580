# MIPS code generated from AST

.data
_L0:  .asciiz "hello world"

.align 2
x: .space 4  # global variable
A: .space 400  # global variable

.text

.globl main
main:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
