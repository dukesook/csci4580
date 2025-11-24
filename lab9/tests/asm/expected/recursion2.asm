#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

foo:			# START of FUNCION

	subu $a0, $sp, 36		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 12($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 12($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 16($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 16($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 20($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 20($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 24($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 24($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 28($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 28($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 32($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 32($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 32		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 256		# expression is a constant
	sw $a0, 8($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 8($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 12($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 12($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 16($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 16($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 20($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 20($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 24($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 24($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 28($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 28($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
