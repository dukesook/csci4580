#  Compilers MIPS code 
.data   


.align 2 

x: .space 4 # global variable
y: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 36		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 8($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1 8($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 12($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1 12($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, x		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 16($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1 16($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 20($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1 20($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 5		# expression is a constant
	sw $a0 24($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1 24($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 100		# expression is a constant
	sw $a0 28($sp)		# Assign store RHS temporarily
	la $a0, y		# EMIT Var global variable
	lw $a1 28($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, y		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 32($sp)		# Assign store RHS temporarily
	la $a0, x		# EMIT Var global variable
	lw $a1 32($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
