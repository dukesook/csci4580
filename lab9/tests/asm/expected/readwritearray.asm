#  Compilers MIPS code 
.data   

_L0: .asciiz	 "enter X"

.align 2 


.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 60		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 0		# expression is a constant
	sw $a0 32($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a1 32($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
_L1:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	beq $a0 $0 _L2		# #WHILE branch out
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 44($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a1 44($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	j _L1		# #WHILE Jump back
_L2:			# # End of WHILE 
	li $a0, 0		# expression is a constant
	sw $a0 40($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a1 40($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
_L3:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 44($sp)		# expression store LHS temporarily
	li $a0, 5		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 44($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	beq $a0 $0 _L4		# #WHILE branch out
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 48($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	mult $a0 $a1		# #EXPR MULT
	mflo $a0		# #EXPR MULT
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 52($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 52($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 56($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 28		# VAR local stack pointer plus offset
	lw $a1 56($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	j _L3		# #WHILE Jump back
_L4:			# # End of WHILE 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
