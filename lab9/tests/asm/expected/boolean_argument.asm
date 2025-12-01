#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

foo:			# START of FUNCION

	subu $a0, $sp, 12		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	li $a0, 1		# expression is a constant
	beq $a0 $0 _L0		# #IF branch to else part

			#  the positive portion of IF
	li $a0, 0		# expression is a constant
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
	j _L1		# #IF S1 end
_L0:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
_L1:			# # End of IF 
	li $a0, 1		# expression is a constant
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 32		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 0		# expression is a constant
	sw $a0 12($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a1 12($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
_L2:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	beq $a0 $0 _L3		# #WHILE branch out
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 24($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a1 24($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


			# Setting Up Function Call
			# evaluate  Function Parameters
	li $a0, 1		# expression is a constant
	sw $a0, 28($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 28($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal foo			# Call the function


	j _L3
		# BREAK Statement line ump inside of while
	j _L2		# #WHILE Jump back
_L3:			# # End of WHILE 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
