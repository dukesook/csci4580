# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
foo:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	sw $t1, 12($sp)		# Load formal parameter into temp variable
	sw $t2, 16($sp)		# Load formal parameter into temp variable
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# Function Call
	li $a0, 18		# Expression is a constant
	sw $a0, 16($sp)		# Push argument onto stack
	li $a0, 55		# Expression is a constant
	sw $a0, 12($sp)		# Push argument onto stack
	li $a0, 79		# Expression is a constant
	sw $a0, 8($sp)		# Push argument onto stack
	lw $a0, 8($sp)		# Load argument into $a register
	move $t2, $a0		# Move argument into temp variable
	lw $a0, 12($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	lw $a0, 16($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal foo		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
