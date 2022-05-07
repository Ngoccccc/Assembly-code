.data
output1: .asciiz "\nPlease input a value: "
output2: .asciiz "\nInput value: "
output3: .asciiz "\nResult after the first XOR: "
output4: .asciiz "\nResult after the second XOR: "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, output1
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s0, $v0
	
	ori $v0, $zero, 4
	la $a0, output2
	syscall
	
	ori $v0, $zero, 34
	move $a0, $s0
	syscall 
	
	ori $v0, $zero, 4
	la $a0, output3
	syscall
	
	xori $s0, $s0, 0xffffffff
	move $a0, $s0
	
	ori $v0, $zero, 34
	syscall 
	
	ori $v0, $zero, 4
	la $a0, output4
	syscall
	
	xori $s0, $s0, 0xffffffff
	move $a0, $s0
	
	ori $v0, $zero, 34
	syscall 
	
	ori $v0, $zero, 10
	syscall