#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 8		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 5		# expression is a constant
	beq $a0 $0 _L0		# #IF branch to else part

			#  the positive portion of IF
	j _L1		# #IF S1 end
_L0:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
_L1:			# # End of IF 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
