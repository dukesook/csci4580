#  Compilers MIPS code 
.data   

_L0: .asciiz	 "true"

.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 16		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 1		# expression is a constant
	sw $a0 12($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a1 12($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 1		# expression is a constant
	beq $a0 $0 _L1		# #IF branch to else part

			#  the positive portion of IF
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	j _L2		# #IF S1 end
_L1:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
_L2:			# # End of IF 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
