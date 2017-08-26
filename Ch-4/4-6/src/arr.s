.section .bss
	.align 	32
	.type 	val, @object
	.size	val, 800
val:
	.zero	800
.section .text
	.globl 	main
	.type 	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl 	$-16, %esp
	subl	$16, %esp
	movl	$5, %edx
	movl	$val, %ebx
	leal	(%ebx, %edx,8), %eax
	movl	$0, 0(%esp)
	call	exit
	movl	%ebp, %esp
	popl	%ebp
	ret
