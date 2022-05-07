.data
o1: .asciiz "Nhap 1 chu:"
o2: .asciiz "\nKet qua nhan voi 10: "
o3: .asciiz "\nKet qua thuc te: "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, o1
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $s0, $v0
	
	sll $t0, $s0, 3
	sll $t1, $s0, 1
	add $t3, $t0, $t1
	ori $t5, $zero, 10
	mul $t4, $s0, 10
	
	 
	ori $v0, $zero, 4
	la $a0, o2
	syscall
	
	ori $v0, $zero, 1
	or $a0, $zero, $t3
	syscall
	
	ori $v0, $zero, 4
	la $a0, o3
	syscall
	
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	
	ori $v0, $zero, 10
	syscall