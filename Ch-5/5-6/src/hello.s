	.file	"hello.c"
.globl arr1
	.data
	.type	arr1, @object
	.size	arr1, 10
arr1:
	.string	"hello"
	.zero	4
.globl arr2
	.type	arr2, @object
	.size	arr2, 20
arr2:
	.string	"world"
	.zero	14
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	$5, 8(%esp)
	movl	$arr2, 4(%esp)
	movl	$arr1, (%esp)
	call	strncpy1
	movl	$arr1, (%esp)
	call	puts
	movl	$0, (%esp)
	call	exit
	.size	main, .-main
.globl strncpy1
	.type	strncpy1, @function
strncpy1:
	pushl	%ebp
	movl	%esp, %ebp
	jmp	.L4
.L6:
	movl	12(%ebp), %eax
	movzbl	(%eax), %edx
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	addl	$1, 8(%ebp)
	addl	$1, 12(%ebp)
.L4:
	movl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	.L10
	cmpl	$0, 16(%ebp)
	setg	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L6
	jmp	.L7
.L8:
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	addl	$1, 8(%ebp)
	jmp	.L7
.L10:
	nop
.L7:
	cmpl	$0, 16(%ebp)
	setg	%al
	subl	$1, 16(%ebp)
	testb	%al, %al
	jne	.L8
	popl	%ebp
	ret
	.size	strncpy1, .-strncpy1
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
