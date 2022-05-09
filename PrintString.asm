.text
main:
	la $a0, prompt
	jal PrintString
	li $v0, 5
	syscall
	move $s0, $v0
	
	#prin the value back to the user
	jal PrintNewLine
	la $a0, result
	jal PrintString
	li $v0, 1
	move $a0, $s0
	syscall
	
	#call the exit subprogram to exit
	jal Exit
.data
	prompt: .asciiz "Please enter an integer: "
	result: .asciiz "\n You entered: "

.text
PrintNewLine:
	li $v0, 4
	la $a0, __PNL_newLine
	syscall
	jr $ra
.data
	__PNL_newLine: .asciiz "\n"
	
.text
PrintString:
	addi $v0, $zero,4
	syscall
	jr $ra



.text
Exit:
	li $v0,10
	syscall