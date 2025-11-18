#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 12		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 57		# expression is a constant
	sw $a0, 8($sp)		# expression store LHS temporarily
	li $a0, 29		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 8($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
