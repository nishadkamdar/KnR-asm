	.file	"intpromo.c"
.globl ch
	.data
	.type	ch, @object
	.size	ch, 1
ch:
	.byte	12
	.comm	ch1,1,1
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movzbl	ch, %eax
	addl	$1, %eax
	movb	%al, ch1
	movl	$0, (%esp)
	call	exit
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
