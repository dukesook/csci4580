# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 44		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 50		# Expression is a constant
	sw $a0, 12($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 12($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# Expression LT
	li $a0, 50		# Expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a1, $a1, 1		# Expression LE adjust
	slt $a0, $a0, $a1		# Expression LE
	li $a0, 50		# Expression is a constant
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	slt $a0, $a1, $a0		# Expression GT
	li $a0, 50		# Expression is a constant
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	add $a0, $a0, 1		# Expression GE adjust
	slt $a0, $a1, $a0		# Expression GE
	li $a0, 50		# Expression is a constant
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
	li $a0, 50		# Expression is a constant
	sw $a0, 32($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression NE part 1
	slt $t3, $a1, $a0		# Expression NE part 2
	or $a0, $t2, $t3		# Expression NE final
	li $a0, 1		# Expression is a constant
	li $a0, 0		# Expression is a constant
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 36($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
