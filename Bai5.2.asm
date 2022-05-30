.text 
PrintNewLine:
	li $v0,4
	la $a0,PNL
	syscall
	jr $ra
.data
	PNL: .asciiz "\n"
# Tại vì trước nhãn PrintTab là chỉ thị .data nên máy hiểu nhầm
# Để có thể sử dụng được chương chình con thì chỉ cần thêm chỉ thị .text trước nhãn PrintTab
PrintTab:
	li $v0,4
	la $a0,tab
	syscall
	jr $ra
.data
	tab: .asciiz "\t"

