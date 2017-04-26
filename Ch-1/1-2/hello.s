.section .rodata
	.globl output
	.type output, @object
	.size output, 13
	.align 4
	output:
	.string "Hello World\7"
	.globl output2
	.type output2, @object
	.size output2, 13
	.align 4
	output2:
	.string "Hello World\y"
	.globl output3
	.type output3, @object
	.size output3, 13
	.align 4
	output3:
	.string "Hello World\?"
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	pushl $output
	call printf
	pushl $output2
	call printf
	pushl $output3
	call printf
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
	
