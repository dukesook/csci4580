#  Compilers MIPS code 
.data   


.align 2 

x: .space 400 # global variable
g: .space 4 # global variable

.text  

.globl main 

main:			# START of FUNCION

	subu $a0, $sp, 148		# # adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# # adjust the stack pointer


	li $a0, 1		# expression is a constant
	sw $a0 92($sp)		# Assign store RHS temporarily
	li $a0, 0		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 92($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	sw $a0 96($sp)		# Assign store RHS temporarily
	li $a0, 18		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 96($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 100($sp)		# Assign store RHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 100($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 20		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 104($sp)		# Assign store RHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 104($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 88		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 108($sp)		# Assign store RHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 108($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, g		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 112($sp)		# Assign store RHS temporarily
	li $a0, 4		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 112($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 5		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 116($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 88		# VAR local stack pointer plus offset
	lw $a1 116($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 1		# expression is a constant
	sw $a0 120($sp)		# Assign store RHS temporarily
	li $a0, 0		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 120($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	sw $a0 124($sp)		# Assign store RHS temporarily
	li $a0, 18		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 124($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	la $a0, x		# EMIT Var global variable
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 128($sp)		# Assign store RHS temporarily
	li $a0, 1		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 128($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 20		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 132($sp)		# Assign store RHS temporarily
	li $a0, 2		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 132($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 88		# VAR local stack pointer plus offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 136($sp)		# Assign store RHS temporarily
	li $a0, 3		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 136($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	la $a0, g		# EMIT Var global variable
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 140($sp)		# Assign store RHS temporarily
	li $a0, 4		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a1 140($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 5		# expression is a constant
	move $a1, $a0		# VAR copy index array in a1
	sll $a1 $a1 2		# muliply the index by wordszie via SLL
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 8		# VAR local stack pointer plus offset
	add $a0 $a0 $a1		# VAR array add internal offset
	lw $a0, ($a0)		# Expression is a VAR
	sw $a0 144($sp)		# Assign store RHS temporarily
	move $a0 $sp		# VAR local make a copy of stackpointer
	addi $a0 $a0 88		# VAR local stack pointer plus offset
	lw $a1 144($sp)		# Assign get RHS temporarily
	sw $a1 ($a0)		# Assign place RHS into memory
	li $a0, 0		# RETURN has no specified value set to 0
	lw $ra 4($sp)		# restore old environment RA
	lw $sp ($sp)		# Return from function store SP

	li $v0, 10		# Exit from Main we are done
	syscall			# EXIT everything
