# MIPS code generated from AST

.data
_L0:  .asciiz "enter a number "
_L1:  .asciiz "the number you entered is: "
_L2:  .asciiz "\n"

.align 2
x: .space 4  # global variable

.text

.globl main
main:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


	la $a0, x		# EMIT Var global variable
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable

	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a variable, get value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




	li $v0, 4		# # print a string
	la $a0, _L2		# # print fetch string location
	syscall		# Perform a write string


	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
