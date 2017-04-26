.equ MAXLINE, 1000
.section .rodata
	output1:
	.string "%d, %s"
	output2:
	.string "%s"
.section .text
	.globl getline
	.type getline, @function
	.globl copy
	.type copy, @function
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $1008, %esp
	jmp cnd1
for1:
	movl -4(%ebp), %eax
	cmpl $80, %eax
	jng cnd1
	leal -1008(%ebp), %eax
	movl -4(%ebp), %ebx
	pushl %eax
	pushl %ebx
	pushl $output1
	call printf
	addl $12, %esp
cnd1:
	movl $MAXLINE, %ebx
	pushl %ebx
	leal -1008(%ebp), %eax
	pushl %eax
	call getline
	addl $8, %esp
	movl %eax, -4(%ebp)
	cmpl $0, %eax
	jg for1
	movl $0, %eax
	call exit	
getline:
	pushl %ebp
	movl %esp, %ebp
	subl $12, %esp
	movl $0, -12(%ebp)
	movl $0, -8(%ebp)
	jmp cnd2
for2:
	movl 12(%ebp), %ebx
	subl $2, %ebx
	movl -8(%ebp), %eax	
	cmpl %ebx, %eax
	jnl out3
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl -4(%ebp), %ebx
	movl %ebx, (%eax)
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
out3:	
	movl -8(%ebp), %eax
	addl $1, %eax
	movl %eax, -8(%ebp)
cnd2:
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax	
	je out2
	movl -4(%ebp), %eax
	cmpl $10, %eax
	jne for2
out2:	
	movl -4(%ebp), %eax
	cmp $10, %eax
	jne out4
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl -4(%ebp), %ebx
	movl %ebx, (%eax)
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	addl $1, %eax
	movl %eax, -8(%ebp)
out4:
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl $0, %ebx
	movl %ebx, (%eax)
	movl -8(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
copy:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, -4(%ebp)
	jmp cndcpy
forcopy:
	movl -4(%ebp), %eax
	addl $1, %eax
	movl %eax, -4(%ebp)
cndcpy:
	movl 8(%ebp), %ecx
	movl -4(%ebp), %ebx
	leal (%ecx, %ebx, 1), %eax
	movl 12(%ebp), %ecx
	movl -4(%ebp), %ebx
	leal (%ecx, %ebx, 1), %edx
	movl (%edx), %ebx
	movl %ebx, (%eax)
	cmpl $0, (%eax)
	jne forcopy 
	movl %ebp, %esp
	popl %ebp
	movl $0, %eax
	ret
