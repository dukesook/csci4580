#  Compilers MIPS code 
.data   


.align 2 

g: .space 400 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 16		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
			# Setting Up Function Call
			# evaluate  Function Parameters
	la $a0, g		# EMIT Var global variable
	sw $a0, 12($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 12($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal main			# Call the function


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
