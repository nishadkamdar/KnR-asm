.equ TABSTOP,8
.section .data
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
	jmp cnd1
while1:
	movl -4(%ebp), %eax
	cmpl $9, %eax
	jne elsif
	movl $4, -8(%ebp)
	jmp cnd2
while2:
	movl $32, (%esp)
	call putchar
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
	movl -8(%ebp), %eax
	subl $1, %eax
	movl %eax, -8(%ebp)
cnd2:
	movl -8(%ebp), %eax
	cmpl $0, %eax
	jg while2
	jmp cnd1
elsif:
	movl -4(%ebp), %eax
	cmpl $10, %eax
	jne els
	movl -4(%ebp), %eax
	movl %eax, (%esp)
	call putchar
	movl $1, -12(%ebp)
	jmp cnd1
els:
	movl -4(%ebp), %eax
	movl %eax, (%esp)
	call putchar
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
cnd1:
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne while1
	movl $0, (%esp)
	call exit
