# MIPS code generated from AST

.data

.align 2
x: .space 400  # global variable
g: .space 4  # global variable

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 148		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 1		# Expression is a constant
	sw $a0, 92($sp)		# Assign store RHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 92($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 2		# Expression is a constant
	sw $a0, 96($sp)		# Assign store RHS temporarily
	li $a0, 18		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 96($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 100($sp)		# Assign store RHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 100($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 20		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 104($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 104($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 88		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 108($sp)		# Assign store RHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 108($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, g		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 112($sp)		# Assign store RHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 112($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 116($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 88		# EMIT Var local variable
	lw $a1, 116($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 1		# Expression is a constant
	sw $a0, 120($sp)		# Assign store RHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 120($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 2		# Expression is a constant
	sw $a0, 124($sp)		# Assign store RHS temporarily
	li $a0, 18		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 124($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	la $a0, x		# EMIT Var global variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 128($sp)		# Assign store RHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 128($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 20		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 132($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 132($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 88		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 136($sp)		# Assign store RHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 136($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	la $a0, g		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 140($sp)		# Assign store RHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 140($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	sw $a0, 144($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 88		# EMIT Var local variable
	lw $a1, 144($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
