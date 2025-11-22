#  Compilers MIPS code 
.data   


.align 2 


.text  

.globl main 

foo:			# START of FUNCION

	subu $a0, $sp, 8		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


_L0:			# # WHILE TOP target
	li $a0, 1		# expression is a constant
	beq $a0 $0 _L1		# #WHILE branch out
	j _L1
		# BREAK Statement line ump inside of while
_L2:			# # WHILE TOP target
	li $a0, 0		# expression is a constant
	beq $a0 $0 _L3		# #WHILE branch out
_L4:			# # WHILE TOP target
	li $a0, 1		# expression is a constant
	beq $a0 $0 _L5		# #WHILE branch out
	j _L5
		# BREAK Statement line ump inside of while
	j _L4
		# CONTINUE Statement jump inside of while
	j _L4		# #WHILE Jump back
_L5:			# # End of WHILE 
	j _L2		# #WHILE Jump back
_L3:			# # End of WHILE 
	j _L0
		# CONTINUE Statement jump inside of while
	j _L0		# #WHILE Jump back
_L1:			# # End of WHILE 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 52		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 0		# expression is a constant
	sw $a0 16($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a1 16($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 10		# expression is a constant
	sw $a0 20($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a1 20($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
_L6:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	beq $a0 $0 _L7		# #WHILE branch out
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 32($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a1 32($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	j _L6
		# CONTINUE Statement jump inside of while
_L8:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 0		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	slt $t2 ,$a0, $a1		# #EXPR EQUAL
	slt $t3 ,$a1, $a0		# #EXPR EQUAL
	or $a0 ,$t2, $t3		# #EXPR EQUAL
	beq $a0 $0 _L9		# #WHILE branch out
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	sw $a0 44($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a1 44($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 48($sp)		# expression store LHS temporarily
	li $a0, 100		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	slt $t2 ,$a0, $a1		# #EXPR EQUAL
	slt $t3 ,$a1, $a0		# #EXPR EQUAL
	nor $a0 ,$t2, $t3		# #EXPR EQUAL
	andi $a0 , 1		# #EXPR EQUAL
	beq $a0 $0 _L10		# #IF branch to else part

			#  the positive portion of IF
	j _L9
		# BREAK Statement line ump inside of while
	j _L11		# #IF S1 end
_L10:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
_L11:			# # End of IF 
	j _L8
		# CONTINUE Statement jump inside of while
	j _L8		# #WHILE Jump back
_L9:			# # End of WHILE 
	j _L6		# #WHILE Jump back
_L7:			# # End of WHILE 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
