.data 
x: .space 1000
y: .asciiz "Hello"

.text
strcpy:
	add $s0,$zero,$zero
L1:
	add $t1, $s0, $a1
	
	lb $t2,0($t1)
	add $t3, $s0, $a0
	
	sb $t2,0($t3)
	beq $t2,$zero, end_of_strcpy
	nop
	addi $s0,$s0,1
	j L1
	nop
end_of_strcpy:
	jr $ra
	
.text
main:
	la $t1,y
	la $t3,x
	jal strcpy
	
	li $v0,10
	syscall