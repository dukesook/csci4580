#  Compilers MIPS code 
.data   


.align 2 

y: .space 200 # global variable

.text  

.globl main 

foo:			# START of FUNCION

	subu $a0, $sp, 12		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 276		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 5		# expression is a constant
	sw $a0 208($sp)		# Assign store RHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 208($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 212($sp)		# Assign store RHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 212($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 30		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 216($sp)		# Assign store RHS temporarily
	li $a0, 20		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 216($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 220($sp)		# expression store LHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 220($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 224($sp)		# expression store LHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 224($sp)		# expression restore LHS from memory
	div $a0 $a1		# #EXPR DIV
	mflo $a0		# #EXPR DIV
	sw $a0, 236($sp)		# expression store LHS temporarily
	li $a0, 78		# expression is a constant
	sw $a0, 232($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	sw $a0, 228($sp)		# expression store LHS temporarily
	li $a0, 8		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 228($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 232($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 236($sp)		# expression restore LHS from memory
	mult $a0 $a1		# #EXPR MULT
	mflo $a0		# #EXPR MULT
	sw $a0 240($sp)		# Assign store RHS temporarily
	li $a0, 45		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 240($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 3		# expression is a constant
	sw $a0, 252($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 252($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 260($sp)		# expression store LHS temporarily
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 3		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 256($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 256($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 260($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 264($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 264($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	sw $a0, 268($sp)		# expression store LHS temporarily
	li $a0, 0		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 268($sp)		# expression restore LHS from memory
	div $a0 $a1		# #EXPR DIV
	mflo $a0		# #EXPR DIV
	sw $a0 272($sp)		# Assign store RHS temporarily
			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 3		# expression is a constant
	sw $a0, 244($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 244($sp)		# expression restore LHS from memory
	div $a0 $a1		# #EXPR DIV
	mflo $a0		# #EXPR DIV
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 248($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 248($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, y		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 272($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
