
.data 
message: .asciiz "Enter an integer: "
result: .asciiz "The result is: "


.text
	# Ask user to enter an integer
	li $v0, 4		
	la $a0, message
	syscall
	
	# Read an input from user and store the value into $a0	
	li $v0, 5
	syscall
	move $a0, $v0
	
	# Call fib procedure
	jal fib
	
	# Print the result
	move $t0, $v0
	li $v0, 4
	la $a0, result
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	# Terminate program
	li $v0, 10
	syscall
	
fib:
	# Check base case: if the value in $a0 is 1, branch to return_1
	addi $t0, $zero, 1
	beq $a0, $t0, return_1
	
	# Recursive call
	addi $a0, $a0, -1	# Decrement the value of $a0 by 1
	add $sp, $sp, -8	# Allocate 2 spaces for .word in stack
	sw $ra, 4($sp)		# Store the return address in stack
	jal fib			# Call itself again

	# Start calculation
	lw $ra, 4($sp)		# Load the return address into $ra
	lw $a1, 0($sp)		# Load the previous fibonacci number into $a0
	addi $sp, $sp, 8	# Deallocate 2 spaces for .word in stack
	sw $v0, 0($sp)		# Store the previous fibonacci number into stack
	add $v0, $v0, $a1	# Calculate the current fibonacci number
	jr $ra			# Go back to the previous procedure call
	
return_1:
	addi $v0, $zero, 1 	# Load 1 to $v0
	jr $ra			# Stop recursive call and start calculation

