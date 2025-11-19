#  Compilers MIPS code 
.data   

_L0: .asciiz	 "x\n"
_L1: .asciiz	 "not x\n"
_L2: .asciiz	 "y\n"
_L3: .asciiz	 "not y\n"
_L4: .asciiz	 "z\n"
_L5: .asciiz	 "not z\n"

.align 2 

x: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 16		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	sw $t0, 8($sp)		# Load temp variable int formal paramter
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	li $v0, 5		# # read a number from input
	syscall		# #reading a number
	sw $v0, ($a0)		# #store the READ into a mem location

	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	beq $a0 $0 _L6		# #IF branch to else part

			#  the positive portion of IF
	li $v0, 4		# #print a string
	la $a0, _L0		# #print fetch string location
	syscall		# Perform a write string


	j _L7		# #IF S1 end
_L6:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
	li $v0, 4		# #print a string
	la $a0, _L1		# #print fetch string location
	syscall		# Perform a write string


_L7:			# # End of IF 
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	beq $a0 $0 _L8		# #IF branch to else part

			#  the positive portion of IF
	li $v0, 4		# #print a string
	la $a0, _L2		# #print fetch string location
	syscall		# Perform a write string


	j _L9		# #IF S1 end
_L8:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
	li $v0, 4		# #print a string
	la $a0, _L3		# #print fetch string location
	syscall		# Perform a write string


_L9:			# # End of IF 
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 12		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	beq $a0 $0 _L10		# #IF branch to else part

			#  the positive portion of IF
	li $v0, 4		# #print a string
	la $a0, _L4		# #print fetch string location
	syscall		# Perform a write string


	j _L11		# #IF S1 end
_L10:			# # ELSE target

			#  the negative  portion of IF if there is an else
			#  otherwise just these lines
	li $v0, 4		# #print a string
	la $a0, _L5		# #print fetch string location
	syscall		# Perform a write string


_L11:			# # End of IF 
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
