# MIPS code generated from AST

.data
_L0:  .asciiz "\n"

.align 2
size: .space 4  # global variable

.text

.globl main
# Function Declaration
printArray:			# Start of function

	subu $a0, $sp, 36		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	sw $t1, 12($sp)		# Load formal parameter into temp variable

# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 20($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a1, 20($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

_L1:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 24($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# Expression LT
	beq $a0, $0, _L2		# # if expression is 0, jump to end of while
# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 32($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a1, 32($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	j _L1		# # Jump to while start
_L2:
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 60		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 10		# Expression is a constant
	sw $a0, 48($sp)		# Assign store RHS temporarily
	la $a0, size		# EMIT Var global variable
	lw $a1, 48($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	sw $a0, 56($sp)		# Push argument onto stack
	la $a0, size		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 52($sp)		# Push argument onto stack
	lw $a0, 56($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 52($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal printArray		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
