#  Compilers MIPS code 
.data   


.align 2 

x: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 16		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	la $a0, x		# EMIT Var global variable
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
