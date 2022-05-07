.data 
output1: .asciiz"\n Please input a character"
output2: .asciiz"\n Uppercase to lowercase: result when adding with 0x20 "
output3: .asciiz"\n Uppercase to lowercase: result when oring with 0x20 "

.text
.globl main
main:
	ori $v0,$zero,4
	la $a0,output1
	syscall
	
	ori $v0,$zero,12
	syscall
	move $s0,$v0
	
	ori $v0,$zero,4
	la $a0,output2
	syscall
	
	or $t0,$s0,$zero
	addi $a0,$t0,0x20
	ori $v0,$zero,11
	syscall
	
	ori $v0,$zero,4
	la $a0,output3
	syscall
	
	ori $a0,$s0,0x20
	ori $v0,$zero,11
	syscall
	
	ori $v0,$zero,10
	syscall