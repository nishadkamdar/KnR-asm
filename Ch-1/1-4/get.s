	.file	"get.c"
	.section	.rodata
.LC0:
	.string	"c = %d\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	jmp	.L2
.L3:
	movl	$.LC0, %eax
	movl	28(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
.L2:
	call	getchar
	cmpl	$-1, %eax
	setne	%al
	movzbl	%al, %eax
	movl	%eax, 28(%esp)
	cmpl	$0, 28(%esp)
	jne	.L3
	movl	$.LC0, %eax
	movl	28(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
