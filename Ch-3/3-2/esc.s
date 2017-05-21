	.file	"esc.c"
	.comm	s,1000,32
	.comm	t,1000,32
	.comm	line,1000,32
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$0, 28(%esp)
	jmp	.L2
.L3:
	movl	$t, 4(%esp)
	movl	$s, (%esp)
	call	escape
	movl	$s, (%esp)
	call	puts
.L2:
	movl	$1000, 4(%esp)
	movl	$t, (%esp)
	call	getline_1
	movl	%eax, 28(%esp)
	cmpl	$0, 28(%esp)
	jg	.L3
	movl	$0, (%esp)
	call	exit
	.size	main, .-main
.globl getline_1
	.type	getline_1, @function
getline_1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -12(%ebp)
	movl	$0, -16(%ebp)
	jmp	.L6
.L8:
	movl	12(%ebp), %eax
	subl	$1, %eax
	cmpl	-16(%ebp), %eax
	jle	.L7
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movb	%dl, (%eax)
	addl	$1, -12(%ebp)
.L7:
	addl	$1, -16(%ebp)
.L6:
	call	getchar
	movl	%eax, -20(%ebp)
	cmpl	$-1, -20(%ebp)
	jne	.L8
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	movl	-16(%ebp), %eax
	leave
	ret
	.size	getline_1, .-getline_1
.globl escape
	.type	escape, @function
escape:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L11
.L18:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	$92, %eax
	je	.L16
	cmpl	$92, %eax
	jg	.L12
	cmpl	$9, %eax
	je	.L14
	cmpl	$10, %eax
	je	.L15
	cmpl	$8, %eax
	je	.L13
	jmp	.L12
.L15:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$110, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L17
.L14:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$116, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L17
.L16:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L17
.L13:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$98, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L17
.L12:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-8(%ebp), %edx
	addl	12(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
.L17:
	addl	$1, -8(%ebp)
.L11:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L18
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	leave
	ret
	.size	escape, .-escape
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
