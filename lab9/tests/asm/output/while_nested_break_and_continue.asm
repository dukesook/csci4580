# MIPS code generated from AST

.data

.align 2

.text

.globl main
# Function Declaration
foo:			# Start of function

	subu $a0, $sp, 8		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


_L0:  # While loop
	li $a0, 1		# Expression is a constant
	beq $a0, $0, _L1		# # if expression is 0, jump to end of while
	j _L1		# BREAK Statement line jump inside of while
_L2:  # While loop
	li $a0, 0		# Expression is a constant
	beq $a0, $0, _L3		# # if expression is 0, jump to end of while
_L4:  # While loop
	li $a0, 1		# Expression is a constant
	beq $a0, $0, _L5		# # if expression is 0, jump to end of while
	j _L5		# BREAK Statement line jump inside of while
	j _L4		# CONTINUE Statement line jump inside of while
	j _L4		# # Jump to while start
_L5:
	j _L2		# # Jump to while start
_L3:
	j _L0		# CONTINUE Statement line jump inside of while
	j _L0		# # Jump to while start
_L1:
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 52		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 16($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 10		# Expression is a constant
	sw $a0, 20($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 20($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

_L6:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	slt $a0, $a0, $a1		# Expression LT
	beq $a0, $0, _L7		# # if expression is 0, jump to end of while

# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 28($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 28($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 32($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 32($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




	j _L6		# CONTINUE Statement line jump inside of while
_L8:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 36($sp)		# expression store LHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 36($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression NE part 1
	slt $t3, $a1, $a0		# Expression NE part 2
	or $a0, $t2, $t3		# Expression NE final
	beq $a0, $0, _L9		# # if expression is 0, jump to end of while

# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 40($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 40($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 44($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 44($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 48($sp)		# expression store LHS temporarily
	li $a0, 100		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 48($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
	beq $a0, $0, _L10		# # if expression is 0, jump to else
	j _L9		# BREAK Statement line jump inside of while
	j _L11		# # Jump to end of if statement
	_L10:		# # ELSE label
	_L11:		# # End of IF statement
	j _L8		# CONTINUE Statement line jump inside of while
	j _L8		# # Jump to while start
_L9:
	j _L6		# # Jump to while start
_L7:
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
