# MIPS code generated from AST

.data
_L0:  .asciiz "\n===Testing break and continue===\n"
_L1:  .asciiz "while true, if x > 10 then continue, else break\n"
_L2:  .asciiz "  x is: "
_L3:  .asciiz ", continue!\n"
_L4:  .asciiz "ERROR! AFTER CONTINUE"
_L5:  .asciiz ", x is greater than 10, break!\n"
_L6:  .asciiz "broke out of while(true)"
_L7:  .asciiz "\n===Testing while===\n"
_L8:  .asciiz "while (x <= 10), x++:\n "
_L9:  .asciiz " "
_L10:  .asciiz "\n"
_L11:  .asciiz "\n===Testing Array Passing===\n"
_L12:  .asciiz "call printArray() on int nums[10]:\n"
_L13:  .asciiz "\n===Testing Method Calls===\n"
_L14:  .asciiz "Print the fibinachi sequence for 7\n"
_L15:  .asciiz "the result is: "
_L16:  .asciiz "\n"
_L17:  .asciiz "\n===Testing if===\n"
_L18:  .asciiz "if x == 5, write 'five', else write 'not five!'\n"
_L19:  .asciiz "five!\n"
_L20:  .asciiz "not five!"
_L21:  .asciiz "\n===Testing expression===\n"
_L22:  .asciiz "x = 4 + 10 - 6 * 3 / 2: \n  "
_L23:  .asciiz "x: "
_L24:  .asciiz "\n"
_L25:  .asciiz " \n"
_L26:  .asciiz ". "
_L27:  .asciiz "\n"

.align 2

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

_L28:  # While loop
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
	beq $a0, $0, _L29		# # if expression is 0, jump to end of while
# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L26		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 16		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw, $a0, ($a0)		# Load address of array parameter
	add $a0, $a0, $a1		# Compute address of array element
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L27		# # print fetch string location
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

	j _L28		# # Jump to while start
_L29:
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
fib:			# Start of function

	subu $a0, $sp, 36		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
	beq $a0, $0, _L30		# # if expression is 0, jump to else
	li $a0, 0		# Expression is a constant
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	jr $ra		# Return from function
	j _L31		# # Jump to end of if statement
	_L30:		# # ELSE label
	_L31:		# # End of IF statement

# Assignment Statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 24($sp)		# Push argument onto stack
	lw $a0, 24($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fib		# Function call jump and link
	sw $a0, 28($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L25		# # print fetch string location
	syscall		# Perform a write string


	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 12		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 32($sp)		# expression store LHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 32($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP
	jr $ra		# Return from function
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testExpression:			# Start of function

	subu $a0, $sp, 32		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L21		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L22		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
	li $a0, 4		# Expression is a constant
	sw $a0, 12($sp)		# expression store LHS temporarily
	li $a0, 10		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 12($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 24($sp)		# expression store LHS temporarily
	li $a0, 6		# Expression is a constant
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	mult $a0, $a1		# Expression TIMES
	mflo $a0		# EXPR MULT
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	div $a0, $a1		# Expression DIVIDE
	mflo $a0		# EXPR DIV
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 24($sp)		# expression restore LHS from memory
	sub $a0, $a0, $a1		# Expression MINUS
	sw $a0, 28($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 28($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L23		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L24		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testIf:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 5		# Expression is a constant
	sw $a0, 12($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 12($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L17		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L18		# # print fetch string location
	syscall		# Perform a write string


	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	slt $t2, $a0, $a1		# Expression EQ part 1
	slt $t3, $a1, $a0		# Expression EQ part 2
	nor $a0, $t2, $t3		# Expression EQ final
	andi $a0, 1		# Expression EQ result
	beq $a0, $0, _L32		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L19		# # print fetch string location
	syscall		# Perform a write string


	j _L33		# # Jump to end of if statement
	_L32:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L20		# # print fetch string location
	syscall		# Perform a write string


	_L33:		# # End of IF statement
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testMethodCalls:			# Start of function

	subu $a0, $sp, 20		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L13		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L14		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
# Function Call
	li $a0, 7		# Expression is a constant
	sw $a0, 12($sp)		# Push argument onto stack
	lw $a0, 12($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fib		# Function call jump and link
	sw $a0, 16($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L15		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L16		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testArray:			# Start of function

	subu $a0, $sp, 104		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 100		# Expression is a constant
	sw $a0, 52($sp)		# Assign store RHS temporarily
	li $a0, 0		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 52($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 200		# Expression is a constant
	sw $a0, 56($sp)		# Assign store RHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 56($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 300		# Expression is a constant
	sw $a0, 60($sp)		# Assign store RHS temporarily
	li $a0, 2		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 60($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 400		# Expression is a constant
	sw $a0, 64($sp)		# Assign store RHS temporarily
	li $a0, 3		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 64($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 500		# Expression is a constant
	sw $a0, 68($sp)		# Assign store RHS temporarily
	li $a0, 4		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 68($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 600		# Expression is a constant
	sw $a0, 72($sp)		# Assign store RHS temporarily
	li $a0, 5		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 72($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 700		# Expression is a constant
	sw $a0, 76($sp)		# Assign store RHS temporarily
	li $a0, 6		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 76($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 800		# Expression is a constant
	sw $a0, 80($sp)		# Assign store RHS temporarily
	li $a0, 7		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 80($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 900		# Expression is a constant
	sw $a0, 84($sp)		# Assign store RHS temporarily
	li $a0, 8		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 84($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
	li $a0, 1000		# Expression is a constant
	sw $a0, 88($sp)		# Assign store RHS temporarily
	li $a0, 9		# Expression is a constant
	move $a1, $a0		# Copy index into $a1
	sll $a1, $a1, 2		# Multiply index by 4 (word size)
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	add $a0, $a0, $a1		# Compute address of array element
	lw $a1, 88($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L11		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L12		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
	li $a0, 10		# Expression is a constant
	sw $a0, 92($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 48		# EMIT Var local variable
	lw $a1, 92($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	sw $a0, 100($sp)		# Push argument onto stack
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 48		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 96($sp)		# Push argument onto stack
	lw $a0, 100($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 96($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal printArray		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testWhile:			# Start of function

	subu $a0, $sp, 28		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 12($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 12($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L7		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L8		# # print fetch string location
	syscall		# Perform a write string


_L34:  # While loop
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 10		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a1, $a1, 1		# Expression LE adjust
	slt $a0, $a0, $a1		# Expression LE
	beq $a0, $0, _L35		# # if expression is 0, jump to end of while
# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L9		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 24($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 24($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	j _L34		# # Jump to while start
_L35:
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L10		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
testBreakContinue:			# Start of function

	subu $a0, $sp, 28		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
	li $a0, 0		# Expression is a constant
	sw $a0, 12($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 12($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L0		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L1		# # print fetch string location
	syscall		# Perform a write string


_L36:  # While loop
	li $a0, 1		# Expression is a constant
	beq $a0, $0, _L37		# # if expression is 0, jump to end of while
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L2		# # print fetch string location
	syscall		# Perform a write string


# WRITE statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	li $v0, 1		# # print the number
	syscall		# #system call for print number




	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 16($sp)		# expression store LHS temporarily
	li $a0, 10		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 16($sp)		# expression restore LHS from memory
	add $a1, $a1, 1		# Expression LE adjust
	slt $a0, $a0, $a1		# Expression LE
	beq $a0, $0, _L38		# # if expression is 0, jump to else
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L3		# # print fetch string location
	syscall		# Perform a write string



# Assignment Statement
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# expression store LHS temporarily
	li $a0, 1		# Expression is a constant
	move $a1, $a0		# Move RHS into $a1
	lw $a0, 20($sp)		# expression restore LHS from memory
	add $a0, $a0, $a1		# Expression PLUS
	sw $a0, 24($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 24($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

	j _L36		# CONTINUE Statement line jump inside of while
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L4		# # print fetch string location
	syscall		# Perform a write string


	j _L39		# # Jump to end of if statement
	_L38:		# # ELSE label
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L5		# # print fetch string location
	syscall		# Perform a write string


	j _L37		# BREAK Statement line jump inside of while
	_L39:		# # End of IF statement
	j _L36		# # Jump to while start
_L37:
# WRITE statement
	li $v0, 4		# # print a string
	la $a0, _L6		# # print fetch string location
	syscall		# Perform a write string


# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
main:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# Function Call
	jal testExpression		# Function call jump and link
# Function Call
	jal testIf		# Function call jump and link
# Function Call
	jal testWhile		# Function call jump and link
# Function Call
	jal testArray		# Function call jump and link
# Function Call
	jal testMethodCalls		# Function call jump and link
# Function Call
	jal testBreakContinue		# Function call jump and link
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
