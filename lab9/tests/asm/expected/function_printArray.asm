#  Compilers MIPS code 
.data   

_L0: .asciiz	 "\n"

.align 2 

size: .space 4 # global variable

.text  

.globl main 

printArray:			# START of FUNCION

	subu $a0, $sp, 36		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	sw $t1, 12($sp)		# Load temp variable int formal paramter
	li $a0, 0		# expression is a constant
	sw $a0 20($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	lw $a1 20($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
_L1:			# # WHILE TOP target
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 24($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# #EXPR Lessthan
	beq $a0 $0 _L2		# #WHILE branch out
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	sw $a0 32($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 16		# VAR local stack pointer plus offset
	lw $a1 32($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	j _L1		# #WHILE Jump back
_L2:			# # End of WHILE 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 60		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 10		# expression is a constant
	sw $a0 48($sp)		# Assign store RHS temporarily
	la $a0, size		# EMIT Var global variable
	lw $a1 48($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	sw $a0, 56($sp)		# Store call Arg temporarily

	la $a0, size		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 52($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 56($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 
	lw $a0, 52($sp)		# pull out stored  Arg 
	move $t1, $a0		# move arg in temp 

	jal printArray			# Call the function


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
