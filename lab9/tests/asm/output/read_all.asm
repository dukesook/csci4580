# MIPS code generated from AST

.data

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
	la $a0, x		# EMIT Var global variable
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

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
