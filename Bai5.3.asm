.data
result: .asciiz ""
printf_newline: .asciiz "\n"

# Lay 2 tham so dau vao thuc hien phep toan nor
.text
OpNOR: 
	nor $v0,$a0,$a1
	jr $ra
OpNAND:
	and $v0,$a0,$a1
	not $v0,$v0
	jr $ra
OpNOT: 
	not $v0,$a0
	jr $ra
OpMult4:
	sll $v0,$a0,2
	jr $ra
OpMult10:
	sll $v0,$a0,1
	sll $v1,$a0,3
	add $v0,$v0,$v1
	jr $ra
HoanDoi:
	xor $v0,$a0,$a1
	xor $v1,$v0,$a1
	xor $v0,$v0,$a0
	jr $ra
Exit:
	li $v0,10
	syscall
PNL:
	li $v0,4
	la $a0,printf_newline
	syscall
	jr $ra
RCS:
	ror $v0,$a0,1
	and $v1,$a0,0x00000001
	jr $ra
LCS:
	rol $v0,$a0,1
	and $v1,$v0,0x00000001
	jr $ra
To_Lower:
	lw $t0,($a0)
	ori $v0,$t0,0x00202020
	jr $ra
To_Upper:
	lw $t0,($a0)
	andi  $v0,$t0,0x005f5f5f
	jr $ra
PrintString:
	addi $v0,$zero,4
	syscall
	jr $ra
	
	
	
	
	