.data
	yeucaunhap:   .asciiz "Nhap so duong n"
	ketqua: .asciiz "Ket qua la: "
.text
main:
	
	#nhập số nguyên dương n
	li $v0,51
	la $a0,yeucaunhap
	syscall
	move $s0,$a0	#gan gia tri vua nhap vao $s0
	#gán cho thanh s3 bằng 10
	add $s3,$zero,10
	addi $s1,$zero,0 #s1 la bien dem de tim bac
		#ham dem so lan tong cac chu so >= 10
		digitDegree:
			blt $s0,10,Exit   #neu gia tri trong $s0<10 thi in ra ket qua
			addi $t3,$zero,0  #t3 chua gia tri la tong cua cac chu so qua cac lan lap
			#ham tinh tong cac chu so
			sum:
				div $s0,$s3
				mfhi $t0 	#phan du
				mflo $t1	#phan nguyen
				add $t3,$t3,$t0	#tinh tong cac chu so cho vao $t3
				move $s0,$t1 #cho phan nguyen vao $s0 de tiep tuc vong lap
				bnez $t1,sum
			#ham dem so lan lap
			count:
				add $s1,$s1,1     #voi moi lan lap bien dem +1
				move $s0,$t3	#gan tong cac chu so thanh 1 so moi va cho vao $s0
				bge $s0,10,digitDegree #neu $s0 van co gia tri lon hon hoac bang 10 thi lap lai
		Exit:
			move $a1,$s1
			li $v0,56
			la $a0,ketqua
			syscall
		# Exit
		li 	$v0,10
		syscall		

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
				
