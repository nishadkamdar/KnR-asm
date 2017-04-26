.section .rodata
	.globl output
	.type output, @object
	.size output, 13
	.align 4
	output:
	.string "Hello World\n"
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	pushl $output
	call printf
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
	
