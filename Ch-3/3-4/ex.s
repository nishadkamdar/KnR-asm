	.file	"ex.c"
	.comm	t,1000,32
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$0, 28(%esp)
	movl	$t, 4(%esp)
	movl	$-2147483648, (%esp)
	call	itoa
	movl	$t, (%esp)
	call	puts
	movl	$0, (%esp)
	call	exit
	.size	main, .-main
.globl reverse
	.type	reverse, @function
reverse:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -12(%ebp)
	jmp	.L4
.L5:
	addl	$1, -12(%ebp)
.L4:
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L5
	subl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	jne	.L6
	subl	$1, -12(%ebp)
.L6:
	movl	$0, -8(%ebp)
	jmp	.L7
.L8:
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, -1(%ebp)
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	8(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	-1(%ebp), %edx
	movb	%dl, (%eax)
	addl	$1, -8(%ebp)
	subl	$1, -12(%ebp)
.L7:
	movl	-8(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	.L8
	leave
	ret
	.size	reverse, .-reverse
.globl itoa
	.type	itoa, @function
itoa:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	$0, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
.L11:
	movl	-12(%ebp), %eax
	movl	%eax, %ebx
	addl	12(%ebp), %ebx
	movl	8(%ebp), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%ecx, %edx
	subl	%eax, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	movl	%ecx, %eax
	xorl	%edx, %eax
	subl	%ecx, %eax
	addl	$48, %eax
	movb	%al, (%ebx)
	addl	$1, -12(%ebp)
	movl	8(%ebp), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, 8(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L11
	cmpl	$0, -16(%ebp)
	jns	.L12
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$45, (%eax)
	addl	$1, -12(%ebp)
.L12:
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$0, (%eax)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	reverse
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	itoa, .-itoa
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
