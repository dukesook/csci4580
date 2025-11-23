# MIPS code generated from AST

.data
_L0:  .asciiz "enter X"

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 60		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 32($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a1, 32($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

_L1:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# Expression LT
	beq $a0, $0, _L2		# # if expression is 0, jump to end of while
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


# READ statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	li $v0, 5		# 5 in $v0 means: Read an integer from the user
	syscall		# READ INTEGER
	sw $v0, ($a0)		# Store the read value into the variable


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 44($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a1, 44($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	j _L1		# # Jump to while start
_L2:

# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 40($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a1, 40($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

_L3:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 44($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 44($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# Expression LT
	beq $a0, $0, _L4		# # if expression is 0, jump to end of while
# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 48($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	li $v0, 1		# # print the number
	syscall		# #system call for print number





# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 52($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 52($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 56($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 28		# EMIT Var local variable
	lw $a1, 56($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	j _L3		# # Jump to while start
_L4:
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
