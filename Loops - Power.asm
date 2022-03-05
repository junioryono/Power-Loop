.data
	# HEADER
	intro1: .asciiz "=======================================================================\n"
	intro2: .asciiz "Program Description:\tX to the power of Y\n"
	intro3: .asciiz "Author:\t\t\tAmer Yono\n"
	intro4: .asciiz "Creation Date:\t\t09/21/2021\n"
	newline: .asciiz "\n"
	
	string1: .asciiz "Enter x: "
	string2: .asciiz "Enter y: "
	errormsgX1: .asciiz "X must be greater than or equal to 0. Enter another value for x.\n"
	errormsgX2: .asciiz "X must be less than or equal to 12. Enter another value of x.\n"
	errormsgY1: .asciiz "Y must be greater than or equal to 0. Enter another value for y.\n"
	errormsgY2: .asciiz "Y must be less than or equal to 12. Enter another value of y.\n"
	string3: .asciiz " to the power of "
	string4: .asciiz " is "

.text
	# HEADER
	li $v0, 4
	la $a0, intro1
	syscall
	
	li $v0, 4
	la $a0, intro2
	syscall
	
	li $v0, 4
	la $a0, intro3
	syscall
	
	li $v0, 4
	la $a0, intro4
	syscall
	
	li $v0, 4
	la $a0, intro1
	syscall
	
	# LAB

enterX:
	# Load string
	li $v0, 4 
	la $a0, string1
	syscall
	
	# Output string
	li $v0, 5
	syscall
	
	# Store user input
	addi $s0, $v0, 0 
	
	# Output error messages
	blt $s0, 0, ErrorMessageX1
	bgt $s0, 12, ErrorMessageX2
	
enterY:
	# Load string
	li $v0, 4
	la $a0, string2
	syscall
	
	# Output string
	li $v0, 5
	syscall
	
	# Store user input
	addi $s1, $v0, 0
	
	# Output error messages
	blt $s1, 0, ErrorMessageY1
	beqz $s1, Case0
	bgt $s1, 12, ErrorMessageY2
	
	# Add X to exponent loop registry
	addi $s2, $s0, 0
	
Loop:
	# Get exponent
	beq $s1, $t1, exit
	beqz $t1, yIsZero
	mult $s2, $s0
	mflo $s2
	
	addi $t1, $t1, 1
	j Loop
	
yIsZero:
	addi $t1, $t1, 1
	j Loop

Case0:
	# The exponent was 0 the answer is 1
	addi $s2, $zero, 1
	j exit

ErrorMessageX1:
	li $v0, 4
	la $a0, errormsgX1
	syscall
	
	j enterX
	
ErrorMessageX2:
	li $v0, 4
	la $a0, errormsgX2
	syscall
	
	j enterX
	
ErrorMessageY1:
	li $v0, 4
	la $a0, errormsgY1
	syscall
	
	j enterY
	
ErrorMessageY2:
	li $v0, 4
	la $a0, errormsgY2
	syscall
	
	j enterY
	
exit:
	li $v0, 1
	add $a0, $s0, $0
	syscall
	
	li $v0, 4
	la $a0, string3
	syscall
	
	li $v0, 1
	add $a0, $s1, $0
	syscall
	
	li $v0, 4
	la $a0, string4
	syscall
	
	li $v0, 1
	add $a0, $s2, $0
	syscall
	
	li $v0, 10
	syscall	
