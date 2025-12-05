# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	li $a0, 1		# Expression is a constant
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
