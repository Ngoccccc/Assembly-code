
.data 
  sothunhat:        .asciiz "\n Nhap mot so co 3 chu so "
  sothuhai:       .asciiz "\n Nhap so thu hai co 3 chu so "
  daucuapheptinh:     .asciiz "\n Nhap phep tinh\n Nhan a de nhap phep cong\n Nhan b de nhap phep tru \n Nhan c de nhap phep nhan\n Nhan d de nhap phep chia \n "
  co:           .asciiz "\n phat hien \n"
  result:       .asciiz "\n ket qua la :  "
  nhamdau:         .asciiz "\n Xay ra loi. Xin hay nhap lai toan tu\n"
  printResult:   .asciiz "\n nhap f de hien thi ket qua"
  erram:        .asciiz "\nKhong hien thi duoc do ket qua la so am\n."
  
  
.eqv ZERO                   63  # Gia tri byte hien thi so 0 tren den LED
.eqv ONE                    6  # Gia tri byte hien thi so 1 tren den LED
.eqv TWO                    91  # Gia tri byte hien thi so 2 tren den LED
.eqv THREE                  79 # Gia tri byte hien thi so 3 tren den LED
.eqv FOUR                   102  # Gia tri byte hien thi so 4 tren den LED
.eqv FIVE                   109  #Gia tri  byte hien thi so 6 tren den LED
.eqv SIX                    125  #Gia tri  byte hien thi so 6 tren den LED
.eqv SEVEN                  7  # Gia tri byte hien thi so 7 tren den LED 
.eqv EIGHT                  127  # Gia tri byte hien thi so 8 tren den LED
.eqv NINE                   111  # Gia tri byte hien thi so 9 tren den LED

.eqv IN_ADRESS_HEXA_KEYBOARD   0xFFFF0012  # chua byte dieu khien dong cua ban phim
                      
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014  # chua byte tra ve vi tri cua phim duoc bam
  

.eqv LEFT_LED            0xFFFF0010  # chua byte dieu khien den led ben trai
.eqv RIGHT_LED          0xFFFF0011  # chua byte dieu khien den led ben phai
.text 
main: 
      	add $s1,$zero,$zero         	#gia tri lay ra khi bam nut
      	add $s2,$zero,$zero      	#toan tu + - * /
      	add $s3,$zero,$zero     	#chua dau = neu bang 6 thi in ra ket qua
      	add $s5,$zero,$zero 		#so thu nhat
      	add $s6,$zero,$zero 		#so thu hai
      	add $s4,$zero,$zero		#bien dem so
      	add $t6,$zero,$zero      	#gia tri led phai
      	add $t7,$zero,$zero      	#gia tri led trai
start:
     	la $a0,sothunhat
     	li $v0, 4     
     	syscall
  
  	li $t1,IN_ADRESS_HEXA_KEYBOARD   
 	li $t3,0x80      #kiem tra trang thai nhap ban phim
  	sb $t3,0($t1)

   # Nhap so thu nhat
Loop: 
	beq $s4,3,nhapso2
      	nop
     	b Loop 
 
nhapso2:
    	add $s5,$s1,$0 # luu gia tri so thu nhat vao s5
    	add $s1,$0,$0 # reset s1
    	addi $s4,$0,0 # reset bien dem s4
    	move $a0,$s5 
    	li $v0,1
    	syscall 

    	li $t6,0      # reset den
   	li $t7,0 
   	
    	la $a0,sothuhai
   	li $v0,4
    	syscall
Loop1: # Nhap so thu hai
         beq $s4,3,nhaptoantu
         nop
         b Loop1 
nhaptoantu:

  	add $s6,$s1,$0 # LUU SO THU 2 VAO S6
  	add $s1,$0,$0  #RESET S1
  	addi $s4,$0,0 #RESET BIEN DEM S4
 
 	move $a0,$s6  # IN SO THU 2
  	li $v0,1
  	syscall 
  
  	li $t6,0  # reset den led    
  	li $t7,0 

  	la $a0,daucuapheptinh
  	li $v0,4
  	syscall
  	
Loop2:
    	beq $s4,1,nhaptoantu2
    	nop
    	b Loop2    #Wait for interrupt
nhaptoantu2:
     	add $s1,$0,$0 # reset s1
     	addi $s4,$0,0 # reset bien dem s4
     	la $a0,printResult
     	li $v0, 4     
     	syscall
     	beq $s4,3,nhaptoantu
 Loop3: # Cho nhap vao dau = de hien thi ket qua  
   	beq $s3,6, show    #khi nhan f thi gia tri thanh s3 se la 6, sau do se dua ra ket qua
    	nop
    	b Loop3
    show:
   
    case_cong: 
    	bne $s2,1,case_tru  # neu la phep cong
         addu $s7,$s5,$s6 # thuc hien phep cong
         la $a0,result 
         li $v0, 4     
         syscall
         move $a0,$s7 # in ket qua ra console 
         li $v0,1
         syscall 
         j showresult

    case_tru:   
    	bne $s2,2,case_nhan
         la $a0,result
         li $v0, 4     
         syscall
         sub $s7,$s5,$s6
         move $a0,$s7
         li $v0,1
         syscall 
         j showresult
    case_nhan:  
    	bne $s2,3,case_chia
         la $a0,result
         li $v0,4
         syscall 
         mul $s7,$s5,$s6
       	move $a0,$s7
         li $v0,1
         syscall 
         j showresult
    case_chia:  
    	bne $s2,4,error
         la $a0,result
         li $v0,4
         syscall 
         div $s7,$s5,$s6
         move $a0,$s7
         li $v0,1
         syscall 
         j showresult
 error: # bao loi
  	la $a0, nhamdau
  	li $v0, 4     
  	syscall
showresult: li $t9,0
         li $t8,0  
         slt $k1,$s7,$0 # kiem tra ket  qua la so am hay khong 
         bne $k1,$0,loisoam
         div $t8,$s7,10
         mfhi $t9
         beq $t8,0,napLED
         div $t8,$t8,10
         mfhi $t8
napLED: 
          li $t2,LEFT_LED   # hien thi den LED trai
          add $s0,$zero,$t9 # truyen bien right
          jal hienthi
          nop
          li $t2,RIGHT_LED  # hien thi den LED phai
          add $s0,$zero,$t8 # truyen bien left
          jal hienthi
          nop
END:
      	 la $v0, 10   
      	 syscall    
  loisoam: # bao loi ket qua am
          la $a0, erram
          li $v0, 4     
          syscall
          beq $a0, $0,END
          nop
          la $v0, 10
          syscall        
hienthi:    
hienthiso_0:
	 bne $s0,0,hienthiso_1  # case $s0 = 0
      	 li $t4,ZERO
          j napgiatri
hienthiso_1: 
	 bne $s0,1,hienthiso_2  # case $s0 = 1
      	 li $t4,ONE
      	 j napgiatri
hienthiso_2: 
	 bne $s0,2,hienthiso_3  # case $s0 = 2
      	 li $t4,TWO
       	 j napgiatri
hienthiso_3: 
	 bne $s0,3,hienthiso_4  # case $s0 = 3
      	 li $t4,THREE
      	 j napgiatri
hienthiso_4: 
	 bne $s0,4,hienthiso_5  # case $s0 = 4
      	 li $t4,FOUR
       	 j napgiatri
hienthiso_5: 
	bne $s0,5,hienthiso_6  # case $s0 = 5
      	li $t4,FIVE
	j napgiatri
hienthiso_6: 
	bne $s0,6,hienthiso_7  # case $s0 = 6
      	li $t4,SIX
	j napgiatri
hienthiso_7: bne $s0,7,hienthiso_8  # case $s0 = 7
      	li $t4,SEVEN
      	j napgiatri
hienthiso_8: 
	bne $s0,8,hienthiso_9  # case $s0 = 8
	li $t4,EIGHT
      	j napgiatri
hienthiso_9: 
	bne $s0,9,hienthiso_df # case $s0 = 9
      	li $t4,NINE
      	j napgiatri
hienthiso_df:  jr $ra
napgiatri:    
		sb $t4,0($t2)  #t4 la lu gia tri cua cac thanh led
	      	jr $ra
   
.ktext 0x80000180   

     	addi $s4,$s4,1
      
      	jal getInt1
      	nop
      	jal getInt2
      	nop
      	jal getInt3
      	nop
     	jal getInt4
      	nop

return: eret

getInt1: 
	addi $sp,$sp,4
      	sw $ra,0($sp) 
      	li $t1,IN_ADRESS_HEXA_KEYBOARD	  
      	li $t3,0x81     # Kich hoat cho phep bam phim o hang 1
      	sb $t3,0($t1)
      	li $t1,OUT_ADRESS_HEXA_KEYBOARD
      	lb $t3,0($t1)   # Nhan byte the hien vi tri cua phim duoc bam trong hang 1
case_0:   
	li $t5,0x11
      	bne $t3,$t5,case_1  # case 0x11
      	addi $t7,$t6,0    
      	addi $t6,$zero,0  # left = 0
      	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show1
case_1:   
	li $t5,0x21
      	bne $t3,$t5,case_2  # case 0x21
      	addi $t7,$t6,0    
      	addi $t6,$zero,1  # left = 1
      	mul $s1,$s1,10
      	add $s1,$s1,$t6 # factor=factor*10+left
      j show1
case_2:   
	li $t5,0x41
      	bne $t3,$t5,case_3  # case 0x41
      	addi $t7,$t6,0   
      	addi $t6,$zero,2  # left = 2
      	mul $s1,$s1,10
      	add $s1,$s1,$t6 # factor=factor*10+left
      j show1
case_3:   
	li $t5,0xffffff81
      	bne $t3,$t5,case_default1  # case 0xffffff81
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,3  # left = 3
      	mul $s1,$s1,10
      	add $s1,$s1,$t6 # factor=factor*10+left
      	j show1
show1:    
	li $t2,LEFT_LED   # hien thi den LED trai
      	add $s0,$zero,$t6 # truyen bien left
      	jal displayLED
      	nop
      	li $t2,RIGHT_LED  # hien thi den LED phai
      	add $s0,$zero,$t7 # truyen bien right
      	jal displayLED
      	nop
case_default1:   j getInt1rt
getInt1rt: 
	lw $ra,0($sp)
      	addi $sp,$sp,-4
      	jr $ra

getInt2: 
	addi $sp,$sp,4
      	sw $ra,0($sp) 
      	li $t1,IN_ADRESS_HEXA_KEYBOARD
      	li $t3,0x82     # Kich hoat interrupt, cho phep bam phim o hang 1
      	sb $t3,0($t1)
      	li $t1,OUT_ADRESS_HEXA_KEYBOARD
      	lb $t3,0($t1)   # Nhan byte the hien vi tri cua phim duoc bam trong hang 1
case_4:   
	li $t5,0x12
      	bne $t3,$t5,case_5  # case 0x11
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,4  # left = 4
      	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show2
case_5:   
	li $t5,0x22
      	bne $t3,$t5,case_6  # case 0x21
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,5  # left = 5
      	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show2
case_6:   
	li $t5,0x42
      	bne $t3,$t5,case_7  # case 0x41
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,6  # left = 6
      	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show2
case_7:   
	li $t5,0xffffff82
      	bne $t3,$t5,case_default2  # case 0xffffff81
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,7  # left = 7
      	mul $s1,$s1,10
      	add $s1,$s1,$t6 # factor=factor*10+left
      j show2
show2:    
	li $t2,LEFT_LED   # hien thi den LED trai
      	add $s0,$zero,$t6 # truyen bien left
      	jal displayLED
      	nop
      	li $t2,RIGHT_LED  # hien thi den LED phai
      	add $s0,$zero,$t7 # truyen bien right
      	jal displayLED
      	nop
case_default2:   j getInt2rt
getInt2rt: 
	lw $ra,0($sp)
      	addi $sp,$sp,-4
      	jr $ra
      
      
 getInt3: 
 	addi $sp,$sp,4
      	sw $ra,0($sp) 
      	li $t1,IN_ADRESS_HEXA_KEYBOARD
      	li $t3,0x84     # Kich hoat interrupt, cho phep bam phim o hang 3
      	sb $t3,0($t1)
      	li $t1,OUT_ADRESS_HEXA_KEYBOARD
      	lb $t3,0($t1)   # Nhan byte the hien vi tri cua phim duoc bam trong hang 3
case_8:   
	li $t5,0x00000014
      	bne $t3,$t5,case_9  # case 0x14
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,8  # left = 8
     	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show3
case_9:   
	li $t5,0x00000024
      	bne $t3,$t5,case_a  # case 0x24
      	addi $t7,$t6,0    # left=right
      	addi $t6,$zero,9  # left = 9
      	mul $s1,$s1,10
      	add $s1,$s1,$t6   # factor=factor*10+left
      j show3
case_a:   
	li $t5,0x44
         bne $t3,$t5,case_b # case 0x44
        	addi $s2,$0,1
         j case_default3
      
case_b:   
	li $t5,0xffffff84
    	bne $t3,$t5,case_default3
    	addi $s2,$0,2
  	j  case_default3
  
show3:    
	li $t2,LEFT_LED   # hien thi den LED trai
      	add $s0,$zero,$t6 # truyen bien left
      	jal displayLED
      	nop
      	li $t2,RIGHT_LED  # hien thi den LED phai
      	add $s0,$zero,$t7 # truyen bien right
      	jal displayLED
      	nop
case_default3:   j getInt3rt
getInt3rt: 
	lw $ra,0($sp)
      	addi $sp,$sp,-4
      	jr $ra
#-----------------------------------------getcode 4
 getInt4: 
 	addi $sp,$sp,4
      	sw $ra,0($sp) 
      	li $t1,IN_ADRESS_HEXA_KEYBOARD
      	li $t3,0x88     # Kich hoat interrupt, cho phep bam phim o hang 4
      	sb $t3,0($t1)
      	li $t1,OUT_ADRESS_HEXA_KEYBOARD
      	lb $t3,0($t1)   # Nhan byte the hien vi tri cua phim duoc bam trong hang 4

case_c:   
	li $t5,0x18
         bne $t3,$t5,case_d # case 0x44
         addi $s2,$0,3
         j case_default3
      
case_d:   
	li $t5,0x28
         bne $t3,$t5,case_f
         addi $s2,$0,4
         j  case_default4

case_f:   
	li $t5,0xffffff88 
         bne $t3,$t5,case_default4
         addi $s3,$0,6
         j case_default4
  

case_default4:   j getInt4rt
getInt4rt:       
	lw $ra,0($sp)
         addi $sp,$sp,-4
         jr $ra

  
displayLED: 
	addi $sp,$sp,4
      	sw $ra,0($sp)   # save $ra
display:    
hienthi_0: 
	bne $s0,0,hienthi_1  # case $s0 = 0
      	li $t4,ZERO
      	j assign
hienthi_1: 
	bne $s0,1,hienthi_2  # case $s0 = 1
      	li $t4,ONE
      	j assign
hienthi_2: 
	bne $s0,2,hienthi_3  # case $s0 = 2
      	li $t4,TWO
      	j assign
hienthi_3: 
	bne $s0,3,hienthi_4  # case $s0 = 3
      	li $t4,THREE
      	j assign
hienthi_4: 
	bne $s0,4,hienthi_5  # case $s0 = 4
      	li $t4,FOUR
      	j assign
hienthi_5: 
	bne $s0,5,hienthi_6  # case $s0 = 5
      	li $t4,FIVE
      	j assign
hienthi_6: 
	bne $s0,6,hienthi_7  # case $s0 = 6
      	li $t4,SIX
      	j assign
hienthi_7: 
	bne $s0,7,hienthi_8  # case $s0 = 7
      	li $t4,SEVEN
      	j assign
hienthi_8: 
	bne $s0,8,hienthi_9  # case $s0 = 8
      	li $t4,EIGHT
      	j assign
hienthi_9: 
	bne $s0,9,hienthi_df # case $s0 = 9
      	li $t4,NINE
      	j assign
hienthi_df:  j displayLEDrt
assign:   sb $t4,0($t2)
displayLEDrt: 
	lw $ra,0($sp)
      	addi $sp,$sp,-4
      	jr $ra
