.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, -4(%ebp)
	jmp cnd
for:
	pushl -4(%ebp)
	call putchar	
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
