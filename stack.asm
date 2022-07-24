.text
.globl main
main:
	la $a0, array_base
	lw $a1, array_size
	jal PrintIntArray
	jal Exit
	
.data	
	array_size: .word 5
	array_base: .word 12
			 .word 7
			 .word 3
			 .word 5
			 .word 11

.text
# Subprogram: PrintIntArray
# Purpose: print an array of ints
# inputs: $a0 - the base address of the array
# $al - the size of the array

PrintIntArray:
	addi $sp, $sp -16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move $s0, $a0     #save the base of the array to $s0
	
	#initialization for counter loop
	#$s1 is the ending index of the loop
	#$s2 is the loop counter
	
	move $s1, $a1
	move $s2, $zero
	
	la $a0 open_bracket 		#print open bracket
	jal PrintString

loop: 
	#check ending condition
	sge $t0, $s2, $s1
	bnez $t0, end_loop
		sll $t0,$s2,2		#Multiply the loop counter by 4 to get offset leach element is 4 big
		add $t0, $to
				
	