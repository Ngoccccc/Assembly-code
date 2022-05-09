
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
	move $a1, $s0
	jal PrintInt
	jal PrintTab
	jal PrintInt
	#call the exit subprogram to exit
	jal Exit
.data
	prompt: .asciiz "Please enter an integer: "
	result: .asciiz "\n You entered: "
.include "utils.asm"


     
