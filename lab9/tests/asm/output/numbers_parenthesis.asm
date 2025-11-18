# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 104		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 1		# Expression is a constant
	sw $a0, 8($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 8($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 12($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 12($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	li $a0, 1		# Expression is a constant
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 32($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	li $a0, 1		# Expression is a constant
	sw $a0, 52($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 44($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 44($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 48($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 52($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	li $a0, 1		# Expression is a constant
	sw $a0, 56($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 56($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 68($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 60($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 60($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 64($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 64($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 68($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	li $a0, 1		# Expression is a constant
	sw $a0, 72($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 72($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 84($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 80($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	sw $a0, 76($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 76($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 80($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 84($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	li $a0, 1		# Expression is a constant
	sw $a0, 88($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 88($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 100($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	sw $a0, 92($sp)		# expression store LHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 92($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 96($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 96($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 100($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
