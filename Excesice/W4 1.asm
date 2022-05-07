.data
o1: .asciiz "s0 la: "
o2: .asciiz "\nBit MSB cua s0 la: "
o3: .asciiz "\nSau khi xoa bit LSB cua s0, s0 la: "
o4: .asciiz "\nThiet lap bit LSB, s0 la: "
o5: .asciiz "\nXoa s0, s0 la: "

.text
.globl main
main:
	ori $v0, $zero, 4
	la $a0, o1
	syscall
	
	ori $s0, $zero, 0x12345678
	or $a0, $zero, $s0
	ori $v0, $zero, 34
	syscall
	
	ori $v0, $zero, 4
	la $a0, o2
	syscall
	
	srl $t0, $s0, 24
	ori $v0, $zero, 34
	or $a0, $zero, $t0
	syscall
	
	ori $v0, $zero, 4
	la $a0, o3
	syscall
	
	andi $t0, $s0, 0xffffff00
	ori $v0, $zero, 34
	or $a0, $zero, $t0
	syscall
	
	ori $v0, $zero, 4
	la $a0, o4
	syscall
	
	ori $t0, $s0, 0x000000ff
	ori $v0, $zero, 34
	or $a0, $zero, $t0
	syscall
	
	ori $v0, $zero, 4
	la $a0, o5
	syscall
	
	and $s0, $s0, $zero
	ori $v0, $zero, 34
	or $a0, $zero, $s0
	syscall
	
	ori $v0, $zero, 10
	syscall
	
	