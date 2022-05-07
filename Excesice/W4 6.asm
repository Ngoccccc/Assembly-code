.data
o1: .asciiz "Nhap so thu 1:"
o2: .asciiz "\nNhap so thu 2:"
o3: .asciiz "\nKet qua so 1 NAND so 2 = "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, o1
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $t0, $v0
	
	ori $v0, $zero, 4
	la $a0, o2
	syscall
	
	ori $v0, $zero, 5
	syscall
	move $t1, $v0
	
	ori $v0, $zero, 4
	la $a0, o3
	syscall
	
	and $s0, $t0, $t1
	xori $s0, $s0, 0xffffffff
	
	or $a0, $zero, $s0
	ori $v0, $zero, 34
	syscall
	
	ori $v0, $zero, 10
	syscall
	