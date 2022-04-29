.data
result1: .asciiz "\nfirst value ="
result2: .asciiz "\nsecond value="

.text
.globl main
main:
  li $v0, 4
  la $a0,result1
  syscall
   
   li $v0,1	#sai o li $v0 phai la 1 khong phai 4
   li $a0,4
   syscall
   
   li $v0,4  
   la $a0,result2
   syscall
   
   li $v0,1
   li $a0,8
   syscall
   
   addi $v0,$zero,10
   syscall
   
 
                      