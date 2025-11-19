#  Compilers MIPS code 
.data   

_L0: .asciiz	 "true\n"
_L1: .asciiz	 "false\n"

.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 8		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 0		# expression is a constant
	beq $a0 $0 _L2		# #IF branch to else part

			#  the positive portion of IF
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	j _L3		# #IF S1 end
_L2:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
	li $v0, 4		# #print a string
	la $a0, _L1		# #print fetch string location
	syscall		# Perform a write string


_L3:			# # End of IF 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
