.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	
	movl %ebp, %esp	
	popl %ebp
	movl $1, %eax
	call exit
