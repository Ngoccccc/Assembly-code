



.data
      result1: .asciiz
      result2: .asciiz
.text
.globl main
main:
    	addi $s0,$zero, 10
   	addi $s1, $zero,3
   	div $s2,$s0,$s1
  	mul $s2, $s2,$s1
    	addi $v0,$zero,4		
    	la $a0, result1
    	syscall
    	addi $v0, $zero,1
    	move $a0, $s2
    	syscall
    	mul $s2,$s0, $s1 		#Write out (10*3)/3
	div $s2,$s2,$s1
                      
       	addi $v0,$zero,4        
	la $a0, result2
	syscall
	addi $v0, $zero,1
	move $a0, $s2
	syscall
                      #Print the result
	addi $v0, $zero, 10
	syscall
                      #Exit program