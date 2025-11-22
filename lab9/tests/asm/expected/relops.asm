#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 44		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 50		# expression is a constant
	sw $a0, 12($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 12($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	li $a0, 50		# expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a1 ,$a1, 1		# #EXPR LE add one to do compare
	slt $a0 ,$a0, $a1		# #EXPR LE
	li $a0, 50		# expression is a constant
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	slt $a0, $a1, $a0		# #EXPR Greaterthan
	li $a0, 50		# expression is a constant
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	add $a0 ,$a0, 1		# #EXPR  ADD GE
	slt $a0, $a1, $a0		# #EXPR Greaterthan
	li $a0, 50		# expression is a constant
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	slt $t2 ,$a0, $a1		# #EXPR EQUAL
	slt $t3 ,$a1, $a0		# #EXPR EQUAL
	nor $a0 ,$t2, $t3		# #EXPR EQUAL
	andi $a0 , 1		# #EXPR EQUAL
	li $a0, 50		# expression is a constant
	sw $a0, 32($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	slt $t2 ,$a0, $a1		# #EXPR EQUAL
	slt $t3 ,$a1, $a0		# #EXPR EQUAL
	or $a0 ,$t2, $t3		# #EXPR EQUAL
	li $a0, 1		# expression is a constant
			# NOT implemented on purpose
	li $a0, 0		# expression is a constant
			# NOT implemented on purpose
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
			# NOT implemented on purpose
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 36($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 36($sp)		# expression restore LHS from memory
			# AND not implemented on purpose
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 40($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 40($sp)		# expression restore LHS from memory
			# AND not implemented on purpose
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
