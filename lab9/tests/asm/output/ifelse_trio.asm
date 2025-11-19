# MIPS code generated from AST

.data
_L0:  .asciiz "x\n"
_L1:  .asciiz "not x\n"
_L2:  .asciiz "y\n"
_L3:  .asciiz "not y\n"
_L4:  .asciiz "z\n"
_L5:  .asciiz "not z\n"

.align 2
x: .space 4  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 16		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# READ statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable

# READ statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable

# READ statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable

	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	beq $a0, $0, _L6		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


	j _L7		# # Jump to end of if statement
	_L6:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


	_L7:		# # End of IF statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	beq $a0, $0, _L8		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L2		# # print fetch string location
	syscall		# Perform a write string


	j _L9		# # Jump to end of if statement
	_L8:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L3		# # print fetch string location
	syscall		# Perform a write string


	_L9:		# # End of IF statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	beq $a0, $0, _L10		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L4		# # print fetch string location
	syscall		# Perform a write string


	j _L11		# # Jump to end of if statement
	_L10:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L5		# # print fetch string location
	syscall		# Perform a write string


	_L11:		# # End of IF statement
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
