.text
Exit:
	li $v0,10
	syscall

.text
PrintString:
	addi $v0, $zero,4
	syscall
	jr $ra

.text
PrintNewLine:
	li $v0, 4
	la $a0, __PNL_newLine
	syscall
	jr $ra
.data
	__PNL_newLine: .asciiz "\n"
	
.text
PrintInt:
	li $v0, 4
	syscall
	
	move $a0, $a1
	li $v0, 1
	syscall
	
	jr $ra
	
.text
PrintTab:
    li $v0,4
    la $a0, tab
    syscall
    jr $ra
.data
    tab: .asciiz "\t"


.text
PromptInt:
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	jr $ra
.data
printf_newline: .asciiz "\n"

