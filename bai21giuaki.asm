.data

mss1: 	.asciiz "Nhap so nguyen(n): "
mss2: 	.asciiz "digitDegree(n) = "
mss3: 	.asciiz "ERROR\nn < 0!!!"
.text
main:
	add 	$s3,$0,10
	PromptInt:
		# In ra xau mss1
		la 	$a0,mss1
		li 	$v0,4
		syscall
		# Nhap n
		li 	$v0,5
		syscall
		move 	$s0,$v0	# $s0 = n
		### 	Doan nay kiem tra xem so nhap vao co phai so duong hay khong
		blt	$s0,$0,error	# Neu khong duong thi nay bao loi va thoat chuong trinh
		add 	$s1,$s1,$0	# Bac chu so luu o $s1
	# Vong lap dem so lan tong cac chu so lon hon 10
	loop1:
		blt 	$s0,10,Exit_loop1	# Neu dau vao n nho hon 10 thi bac bang 0, nen ta thoat vong lap luon
		add 	$t3,$0,0	# $t3 la tong cua cac chu so
		# Vong lap de tach tung chu so ra khoi so n
		loop2:
			div 	$s0,$s3	# Chia cho $s3=10 de tach lay chu so
			mfhi  	$t0	# Phan du dua vao $t0
			add	$t3,$t3,$t0	# t3 la thanh ghi luu tong cac chu so
			mflo 	$t1	# Thuong luu vao $t1
			move 	$s0,$t1	# Chuyen lai thuong vao $s0 de chia tach tiep cac chu so ra
			bnez	$t1,loop2 # Neu thuong khac 0 thi tiep tuc vong lap chia, con neu bang 0 thi la da tach ra duoc het cac chu so ra
		Exit_loop2:
		add 	$s1,$s1,1	# Ket thuc vong lap tach chu so thi tang bac len 1, do neu da gap vong lap tach thi tuc la $s0 dang lon hon 10
		move 	$s0,$t3		# $t3 luu tong cac chu so cua $s0 nen ta gan lai cho $s0 kiem tra tong do co >= 10 hay ko
		bge	$s0,10,loop1	# Neu tong tinh duoc $t3 >= 10 thi tiep tuc tach de cong lai tong
	Exit_loop1:
	# In ra xau mss2
	la 	$a0,mss2
	li 	$v0,4
	syscall
	# In ra bac cua chu so do duoc luu trong $s1
	move 	$a1,$s1
	li 	$v0,56
	la      $a0,mss2
	syscall
	
	# Exit
	li 	$v0,10
	syscall
	# Bao loi n<0
	error:
	la 	$a0,mss3
	li 	$v0,4
	syscall