#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 24		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 1		# expression is a constant
	sw $a0, 8($sp)		# expression store LHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 8($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 3		# expression is a constant
	sw $a0, 12($sp)		# expression store LHS temporarily
	li $a0, 4		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 12($sp)		# expression restore LHS from memory
	mult $a0 $a1		# #EXPR MULT
	mflo $a0		# #EXPR MULT
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	div $a0 $a1		# #EXPR DIV
	mflo $a0		# #EXPR DIV
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
