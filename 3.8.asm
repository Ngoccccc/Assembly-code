.data
	prompt_x: .asciiz "Enter x: "
	prompt_y: .asciiz "Enter y: "
	prompt_z: .asciiz "Enter z: "
	result_1: .asciiz "5x + 3y + z = "
	result_2: .asciiz "\n((5x + 3y + z) / 2) * 3 = "
	result_3: .asciiz "\nx^3 + 2x^2 + 3x + 4 = "
	result_4: .asciiz "\n(4x / 3) * y = "
.text
.globl main

main:
	#ask for x input
	addi $v0, $zero, 4
	la $a0, prompt_x
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s0, $v0
	
	#ask for y input
	addi $v0, $zero, 4
	la $a0, prompt_y
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s1, $v0
	
	#ask for z input
	addi $v0, $zero, 4
	la $a0, prompt_z
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s2, $v0
	
	mul $s3, $s0, 5
	mul $s4, $s1, 3
	add $s3, $s3, $s4
	add $s3, $s3, $s2
	
	# print 5x + 3y + z 
	addi $v0, $zero, 4
	la $a0, result_1
	syscall
	
	addi $v0, $zero, 1
	move $a0, $s3
	syscall
	
	div $s4, $s3, 2
	mul $s4, $s4, 3
	
	# print ((5x + 3y + z) / 2) * 3 
	addi $v0, $zero, 4
	la $a0, result_2
	syscall
	
	addi $v0, $zero, 1
	move $a0, $s4
	syscall
	
	mul $s6, $s0, $s0
	mul $s5, $s6, $s0
	mul $s6, $s6, 2
	add $s5, $s5, $s6
	mul $s6, $s0, 3
	add $s5, $s5, $s6
	add $s5, $s5, 4

	
	# print x^3 + 2x^2 + 3x + 4 
	addi $v0, $zero, 4
	la $a0, result_3
	syscall
	
	addi $v0, $zero, 1
	move $a0, $s5
	syscall
	
	mul $s6, $s0, 4
	div $s6, $s6, 3
	mul $s6, $s6, $s1
	
	# print (4x / 3) * y 
	addi $v0, $zero, 4
	la $a0, result_4
	syscall
	
	addi $v0, $zero, 1
	move $a0, $s6
	syscall
	
	addi $v0, $zero, 10
	syscall
