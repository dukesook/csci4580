# MIPS code generated from AST

.data
_L0:  .asciiz "enter your number:\n"
_L1:  .asciiz "the result is: "
_L2:  .asciiz "\n"
_L3:  .asciiz "calling fib with x = "
_L4:  .asciiz "\n"
_L5:  .asciiz "  value returned: "
_L6:  .asciiz "\n"

.align 2
size: .space 4  # global variable

.text

.globl main
# Function Declaration
fib:			# Start of function

	subu $a0, $sp, 36		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L3		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L4		# # print fetch string location
	syscall		# Perform a write string


	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
	beq $a0, $0, _L7		# # if expression is 0, jump to else
	li $a0, 0		# Expression is a constant
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	jr $ra		# Return from function
	j _L8		# # Jump to end of if statement
	_L7:		# # ELSE label
	_L8:		# # End of IF statement

# Assignment Statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 24($sp)		# Push argument onto stack
	lw $a0, 24($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fib		# Function call jump and link
	sw $a0, 28($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L5		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L6		# # print fetch string location
	syscall		# Perform a write string


	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 32($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	jr $ra		# Return from function
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 24		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


# READ statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable


# Assignment Statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# Push argument onto stack
	lw $a0, 16($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fib		# Function call jump and link
	sw $a0, 20($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 20($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L2		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
