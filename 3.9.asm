.data
	prompt_x: .asciiz "Enter n: "
	prompt_y: .asciiz "Enter T: "
	prompt_z: .asciiz "Enter P: "
	result_1: .asciiz "V = nRT / P = "
.text
.globl main

main:
	#ask for n input
	addi $v0, $zero, 4
	la $a0, prompt_x
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s0, $v0
	
	#ask for T input
	addi $v0, $zero, 4
	la $a0, prompt_y
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s1, $v0
	
	#ask for P input
	addi $v0, $zero, 4
	la $a0, prompt_z
	syscall
	
	addi $v0, $zero, 5
	syscall 
	move $s2, $v0
	
	mul $s3, $s0, 8314
	mul $s3, $s3, $s1
	div $s3, $s3, 1000
	div $s3, $s3, $s2

	addi $v0, $zero, 4
	la $a0, result_1
	syscall
	
	addi $v0, $zero, 1
	move $a0, $s3
	syscall
	
	addi $v0, $zero, 10
	syscall
