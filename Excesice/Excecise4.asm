.data
outputA: .asciiz "\nPlease input a value of A: "
outputB: .asciiz "\nPlease input a value of B: "
output2A: .asciiz "\nInput value A: "
output2B: .asciiz "\n Input value B: "
output3: .asciiz "\nResult after the first XOR: "
output4: .asciiz "\nResult after the second XOR: "
 
.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, outputA
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s0, $v0
	
	ori $v0, $zero, 4
	la $a0, outputB
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s1, $v0
	
	ori $v0, $zero, 4
	la $a0, output2A
	syscall
	
	ori $v0, $zero, 34
	move $a0, $s0
	syscall 
	
	ori $v0, $zero, 4
	la $a0, output2B
	syscall
	
	ori $v0, $zero, 34
	move $a0, $s1
	syscall
	
	ori $v0, $zero, 4
	la $a0, output3
	syscall
	
	xor $s0, $s0, $s1
	move $a0, $s0
	
	ori $v0, $zero, 34
	syscall 
	
	ori $v0, $zero, 4
	la $a0, output4
	syscall
	
	xor $s0, $s0, $s1
	move $a0, $s0
	
	ori $v0, $zero, 34
	syscall 
	
	ori $v0, $zero, 10
	syscall