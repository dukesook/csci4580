#  Compilers MIPS code 
.data   

_L0: .asciiz	 "hello world"

.align 2 

A: .space 400 # global variable
x: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 12		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
