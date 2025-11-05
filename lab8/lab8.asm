# Devon Sookhoo
# November 5th, 2025
# Lab 8 MIPS with MARS simulator

# Purpose:  This program reads in an integer n from the 
#           user and computes the sum of squares from 0 to n
#           This file was combined from sum100.asm and readwrite.asm

# The data segment
.data
L1:   .asciiz "Please enter value: "
str:  .asciiz "The sum from 0 .. "
str1: .asciiz " is: "

.text  # directive that we are in the code segment


main:
        subu $a0, $sp, 20     # We want 4 mem locations for main SP, RA, i , s
        sw $ra, 4($a0)        # we need to store the RA in the Activation record
        sw $sp, ($a0)         # store SP
        move $sp, $a0         # adjust SP

        sw $0, 8($sp)   # store 0 into memory -- counting variable 
        sw $0, 12($sp)  # store 0 into memory -- accumulating variable
 
 	# Prints the prompt2 string
	li $v0, 4   # print string syscall
	la $a0, L1  # load address of prompt string
	syscall     # perform syscall

	#reads one integer from user and saves in t0
	li $v0, 5           # read integer syscall
	#addu $t0, $sp, 8   # $t0 is the memory location for our variable
	syscall             # now read
	sw $v0 16($sp)      # end of read statement, store n in 16($sp)
 
       
loop:
        lw $t6, 8($sp)        #  Load i
        mul $t7, $t6, $t6     #  i * i
        lw $t8, 12($sp)       #  s
        addu $t9, $t8, $t7    #  s + i*i
        sw $t9, 12($sp)       #  s= s + i*i 
        lw $t6, 8($sp)        #  i 
        addu $t0, $t6, 1      #  i+1
        sw $t0, 8($sp)        #  i = i + 1
        lw $t2, 16($sp)       #  load the for loop max
        ble $t0, $t2, loop    #  keep doing it for 100 times
        nop   # 
        
        la $a0, str     # load address of string
        li $v0 4        # print the string
        syscall         # Perform syscall which prints string
        nop             # do nothing 
        
        lw $a0, 16($sp)  # load n
        li $v0 1 #   Print the number
        syscall      # print n
        
        la $a0, str1 # load address of string
        li $v0 4  #   print the string
        syscall # 
        nop   # 
        
        lw $a0, 12($sp) # load s
        li $v0 1 #   Print the number
        syscall # Point syscall to print s
        
       
        lw $ra, 4($sp) # reset return address
        lw $sp , ($sp)  # put backl Ra and SP
        
        li $v0, 10  # load exit syscall
        syscall     #  exit for MAIN only
        


        
