# MIPS code generated from AST

.data

.align 2
x: .space 4  # global variable
y: .space 4  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 36		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 8($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 8($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 12($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1, 12($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1, 20($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	sw $a0, 24($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 24($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 100		# Expression is a constant
	sw $a0, 28($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 32($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1, 32($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
