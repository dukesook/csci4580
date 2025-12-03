#  Compilers MIPS code 
.data   

_L0: .asciiz	 "calling fib with x = "
_L1: .asciiz	 "\n"
_L2: .asciiz	 "  value returned: "
_L3: .asciiz	 "\n"
_L4: .asciiz	 "enter your number:\n"
_L5: .asciiz	 "the result is: "
_L6: .asciiz	 "\n"

.align 2 

size: .space 4 # global variable

.text  

.globl main 

fib:			# START of FUNCION

	subu $a0, $sp, 36		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L1		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 0		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $t2 ,$a0, $a1		# #EXPR EQUAL
	slt $t3 ,$a1, $a0		# #EXPR EQUAL
	nor $a0 ,$t2, $t3		# #EXPR EQUAL
	andi $a0 , 1		# #EXPR EQUAL
	beq $a0 $0 _L7		# #IF branch to else part

			#  the positive portion of IF
	li $a0, 0		# expression is a constant
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
	j _L8		# #IF S1 end
_L7:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
_L8:			# # End of IF 
			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# #EXPR SUB
	sw $a0, 24($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 24($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal fib			# Call the function


	sw $a0 28($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a1 28($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $v0, 4		# #print a string
	la $a0, _L2		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L3		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 32($sp)		# expression store LHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	move $a1, $a0		# #right hand side needs to be a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# #EXPR ADD
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	jr $ra			# return to the caller
main:			# START of FUNCION

	subu $a0, $sp, 24		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $v0, 4		# #print a string
	la $a0, _L4		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

			# Setting Up Function Call
			# evaluate  Function Parameters
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0, 16($sp)		# Store call Arg temporarily

			# place   Parameters into T registers
	lw $a0, 16($sp)		# pull out stored  Arg 
	move $t0, $a0		# move arg in temp 

	jal fib			# Call the function


	sw $a0 20($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a1 20($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $v0, 4		# #print a string
	la $a0, _L5		# #print fetch string location
	syscall		# Perform a write string


	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	li $v0 1		# #   Print the number
	syscall		# # system call for print number


	li $v0, 4		# #print a string
	la $a0, _L6		# #print fetch string location
	syscall		# Perform a write string


	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
