# MIPS code generated from AST

.data

.align 2
one: .space 4  # global variable
two: .space 4  # global variable
three: .space 4  # global variable
four: .space 4  # global variable
five: .space 4  # global variable
v1: .space 4  # global variable
v2: .space 4  # global variable
v3: .space 4  # global variable
v4: .space 4  # global variable
v5: .space 4  # global variable
bool1: .space 4  # global variable
bool2: .space 4  # global variable
bool3: .space 4  # global variable
bool4: .space 4  # global variable
bool5: .space 4  # global variable
int_one: .space 4  # global variable
int_two: .space 4  # global variable
int_three: .space 4  # global variable
int_four: .space 4  # global variable
int_five: .space 4  # global variable
void_v1: .space 4  # global variable
void_v2: .space 4  # global variable
void_v3: .space 4  # global variable
void_v4: .space 4  # global variable
void_v5: .space 4  # global variable
a_bool1: .space 4  # global variable
b_bool2: .space 4  # global variable
c_bool3: .space 4  # global variable
d_bool4: .space 4  # global variable
e_bool5: .space 4  # global variable

.text

.globl main
# Function Declaration
fun1:			# Start of function

	subu $a0, $sp, 12		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
fun2:			# Start of function

	subu $a0, $sp, 16		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer


	sw $t0, 8($sp)		# Load formal parameter into temp variable
	sw $t1, 12($sp)		# Load formal parameter into temp variable
# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

	jr $ra		# Return from function
# Function Declaration
fun3:			# Start of function

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
fun4:			# Start of function

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

	subu $a0, $sp, 180		# adjust the stack for function setup
	sw $sp, ($a0)		# remember old SP
	sw $ra, 4($a0)		# remember current Return address
	move $sp, $a0		# adjust the stack pointer



# Assignment Statement
# Function Call
	la $a0, one		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 12($sp)		# Push argument onto stack
	lw $a0, 12($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 16($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 16($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, two		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 20($sp)		# Push argument onto stack
	lw $a0, 20($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 24($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 24($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, three		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 28($sp)		# Push argument onto stack
	lw $a0, 28($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 32($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 32($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, four		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 36($sp)		# Push argument onto stack
	lw $a0, 36($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 40($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 40($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, five		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 44($sp)		# Push argument onto stack
	lw $a0, 44($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 48($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 48($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, int_one		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 52($sp)		# Push argument onto stack
	lw $a0, 52($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 56($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 56($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, int_two		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 60($sp)		# Push argument onto stack
	lw $a0, 60($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 64($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 64($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, int_three		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 68($sp)		# Push argument onto stack
	lw $a0, 68($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 72($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 72($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, int_four		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 76($sp)		# Push argument onto stack
	lw $a0, 76($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 80($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 80($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory


# Assignment Statement
# Function Call
	la $a0, int_five		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 84($sp)		# Push argument onto stack
	lw $a0, 84($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	jal fun1		# Function call jump and link
	sw $a0, 88($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 88($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Call
	la $a0, bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 96($sp)		# Push argument onto stack
	la $a0, bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 92($sp)		# Push argument onto stack
	lw $a0, 96($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 92($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 104($sp)		# Push argument onto stack
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 100($sp)		# Push argument onto stack
	lw $a0, 104($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 100($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 112($sp)		# Push argument onto stack
	la $a0, bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 108($sp)		# Push argument onto stack
	lw $a0, 112($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 108($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 120($sp)		# Push argument onto stack
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 116($sp)		# Push argument onto stack
	lw $a0, 120($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 116($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, a_bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 128($sp)		# Push argument onto stack
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 124($sp)		# Push argument onto stack
	lw $a0, 128($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 124($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, bool2		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 136($sp)		# Push argument onto stack
	la $a0, e_bool5		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 132($sp)		# Push argument onto stack
	lw $a0, 136($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 132($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	jal fun2		# Function call jump and link
# Function Call
	la $a0, void_v1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 148($sp)		# Push argument onto stack
	la $a0, void_v4		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 144($sp)		# Push argument onto stack
	la $a0, v5		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 140($sp)		# Push argument onto stack
	lw $a0, 148($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 144($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	lw $a0, 140($sp)		# Load argument into $a register
	move $t2, $a0		# Move argument into temp variable
	jal fun3		# Function call jump and link
# Function Call
	la $a0, v5		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 160($sp)		# Push argument onto stack
	la $a0, void_v4		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 156($sp)		# Push argument onto stack
	la $a0, v1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 152($sp)		# Push argument onto stack
	lw $a0, 160($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 156($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	lw $a0, 152($sp)		# Load argument into $a register
	move $t2, $a0		# Move argument into temp variable
	jal fun3		# Function call jump and link

# Assignment Statement
# Function Call
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 172($sp)		# Push argument onto stack
	la $a0, bool1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 168($sp)		# Push argument onto stack
	la $a0, v1		# EMIT Var global variable
	lw $a0, ($a0)		# # load variable value
	sw $a0, 164($sp)		# Push argument onto stack
	lw $a0, 172($sp)		# Load argument into $a register
	move $t0, $a0		# Move argument into temp variable
	lw $a0, 168($sp)		# Load argument into $a register
	move $t1, $a0		# Move argument into temp variable
	lw $a0, 164($sp)		# Load argument into $a register
	move $t2, $a0		# Move argument into temp variable
	jal fun4		# Function call jump and link
	sw $a0, 176($sp)		# Assign store RHS temporarily
	move $a0, $sp		# VAR local make a copy of stackpointer
	addi $a0, $a0, 8		# EMIT Var local variable
	lw $a1, 176($sp)		# Assign get RHS temporarily
	sw $a1, ($a0)		# Assign place RHS into memory

# Function Return
	li $a0, 0		# restore RA
	lw $ra, 4($sp)		# restore old environment RA
	lw $sp, ($sp)		# Return from function store SP

# Exit from main function
	li $v0, 10		# Exit from Main we are done
	syscall		# EXIT everything
