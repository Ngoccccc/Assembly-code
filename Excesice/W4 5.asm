.data
o1: .asciiz "Nhap 1 so:"
o2: .asciiz "\nSo bu 2 la: "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, o1
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s0, $v0
	
	or $a0, $s0, $zero
	ori $v0, $zero, 34
	syscall
	
	xori $s0, $s0, 0xffffffff
	addi $s0, $s0, 0x00000001
	
	ori $v0, $zero, 4
	la $a0, o2
	syscall
	
	or $a0, $s0, $zero
	ori $v0, $zero, 34
	syscall
	
	ori $v0, $zero, 10
	syscall