.data
o1: .asciiz "Nhap so thu 1:"
o2: .asciiz "\nNhap so boi cua 2: "
o3: .asciiz "\nKet qua = "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, o1
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s0, $v0
	
	ori $v0, $zero, 4
	la $a0, o2
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s1, $v0
	
	mul $s0, $s0, $s1
	
	ori $v0, $zero, 4
	la $a0, o3
	syscall
	
	ori $v0, $zero, 1
	or $a0, $zero, $s0
	syscall
	
	ori $v0, $zero, 10
	syscall
	