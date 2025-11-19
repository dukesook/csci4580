#  Compilers MIPS code 
.data   


.align 2 

y: .space 4 # global variable
x: .space 400 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 8		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 99		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
