.equ MAXLINE, 1000
.equ EXIT_SUCCESS, 0
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
	.globl remove
	.type remove, @function
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $4016, %esp
	jmp cnd1
for1:
	leal -4000(%ebp), %eax
	movl %eax, (%esp)
	call remove
	cmpl $0, %eax
	jng cnd1
	leal -4000(%ebp), %eax
	movl %eax, 4(%esp)
	movl $output2, (%esp)
	call printf
cnd1:
	movl $MAXLINE, %ebx
	movl %ebx, 4(%esp)
	leal -4000(%ebp), %eax
	movl %eax, (%esp)
	call getline
	cmpl $0, %eax
	jg for1
	movl $EXIT_SUCCESS, (%esp)
	call exit	
getline:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
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
	leal (%ecx, %ebx, 4), %eax
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
	leal (%ecx, %ebx, 4), %eax
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
	leal (%ecx, %ebx, 4), %eax
	movl $0, (%eax)
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
	leal (%ecx, %ebx, 4), %eax
	movl 12(%ebp), %ecx
	movl -4(%ebp), %ebx
	leal (%ecx, %ebx, 4), %edx
	movl (%edx), %ebx
	movl %ebx, (%eax)
	cmpl $0, (%eax)
	jne forcopy 
	movl %ebp, %esp
	popl %ebp
	movl $0, %eax
	ret
remove:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -4(%ebp)
	jmp cndrem1
forrem1:
	movl -4(%ebp), %eax
	addl $1, %eax
	movl %eax, -4(%ebp)	
cndrem1:
	movl 8(%ebp), %ebx
	movl -4(%ebp), %ecx
	leal (%ebx, %ecx, 4), %eax
	cmpl $10, (%eax)
	jne forrem1
	movl -4(%ebp), %eax
	subl $1, %eax
	movl %eax, -4(%ebp)	
	jmp cndrem2
forrem2:
	movl -4(%ebp), %eax
	subl $1, %eax
	movl %eax, -4(%ebp)	
cndrem2:
	movl -4(%ebp), %eax
	cmpl $0, %eax
	jnge outrem1
	movl 8(%ebp), %ebx
	movl -4(%ebp), %ecx
	leal (%ebx, %ecx, 4), %eax
	cmpl $32, (%eax)
	je forrem2
	cmpl $9, (%eax)
	je forrem2
outrem1:
	movl -4(%ebp), %eax
	cmpl $0, %eax
	jnge outrem2
	movl -4(%ebp), %eax
	addl $1, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %ebx
	movl -4(%ebp), %ecx
	leal (%ebx, %ecx, 4), %eax
	movl $10, (%eax)
	movl -4(%ebp), %eax
	addl $1, %eax
	movl %eax, -4(%ebp)
	movl 8(%ebp), %ebx
	movl -4(%ebp), %ecx
	leal (%ebx, %ecx, 4), %eax
	movl $0, (%eax)
outrem2:
	movl -4(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
	
