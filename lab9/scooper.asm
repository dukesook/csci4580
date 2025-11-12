#  Compilers MIPS code 
.data   

_L0: .asciiz	 "enter a number "
_L1: .asciiz	 "the number you entered is: "
_L2: .asciiz	 "\n"
_L3: .asciiz	 "my favorite number is: "
_L4: .asciiz	 "\n"

.align 2 

x: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 8		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	la $a0, x		# EMIT Var global variable
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	li $v0, 4		# #print a string
	la $a0, _L1		# #print fetch string location
	syscall		# Perform a write string


	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L2		# #print fetch string location
	syscall		# Perform a write string


	li $v0, 4		# #print a string
	la $a0, _L3		# #print fetch string location
	syscall		# Perform a write string


	li $a0, 1000		# expression is a constant
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L4		# #print fetch string location
	syscall		# Perform a write string


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
