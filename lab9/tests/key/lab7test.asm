#  Compilers MIPS code 
.data   


.align 2 

y: .space 4 # global variable
Z: .space 400 # global variable
z: .space 4 # global variable

.text  

.globl main 

f:			# START of FUNCION

	subu $a0, $sp, 84		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 76($sp)		# expression store LHS temporarily
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 5		# expression is a constant
	sw $a0, 68($sp)		# expression store LHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 64($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 64($sp)		# expression restore LHS from memory
	mult $a0 $a1		# #EXPR MULT
	mflo $a0		# #EXPR MULT
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 68($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 72($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 72($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal f			# Call the function


	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 76($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 80($sp)		# Assign store RHS temporarily
	li $a0, 2		# expression is a constant
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 60($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 60($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 80($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 76($sp)		# expression store LHS temporarily
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 5		# expression is a constant
	sw $a0, 68($sp)		# expression store LHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 64($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 64($sp)		# expression restore LHS from memory
	mult $a0 $a1		# #EXPR MULT
	mflo $a0		# #EXPR MULT
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 68($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 72($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 72($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal f			# Call the function


	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 76($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 80($sp)		# Assign store RHS temporarily
	li $a0, 2		# expression is a constant
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 60($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 60($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 80($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 56		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	sw $t1, 12($sp)		# Load temp variable int formal paramter
			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0 ($a0)		# Get address of function array parameter
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 24($sp)		# expression store LHS temporarily
	la $a0, z		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	sw $a0, 28($sp)		# expression store LHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 32($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 32($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal f			# Call the function


	li $v0 1		# #   Print the number
	syscall		# # system call for print number


			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0 ($a0)		# Get address of function array parameter
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 44($sp)		# expression store LHS temporarily
	la $a0, z		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 44($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	sw $a0, 48($sp)		# expression store LHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 52($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 52($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal f			# Call the function


	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
