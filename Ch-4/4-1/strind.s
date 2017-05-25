	.file	"strind.c"
.globl pattern
	.section	.rodata
.LC0:
	.string	"ould"
	.data
	.align 4
	.type	pattern, @object
	.size	pattern, 4
pattern:
	.long	.LC0
	.comm	s,1000,32
	.comm	t,1000,32
	.comm	line,1000,32
	.section	.rodata
.LC1:
	.string	"Pattern not found"
.LC2:
	.string	"Right most index is %d\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$0, 24(%esp)
	movl	$0, 28(%esp)
	jmp	.L2
.L4:
	movl	pattern, %eax
	movl	%eax, 4(%esp)
	movl	$t, (%esp)
	call	strindex
	movl	%eax, 28(%esp)
	cmpl	$0, 28(%esp)
	jns	.L3
	movl	$.LC1, (%esp)
	call	puts
	jmp	.L2
.L3:
	movl	$.LC2, %eax
	movl	28(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
.L2:
	movl	$1000, 4(%esp)
	movl	$t, (%esp)
	call	getline_1
	movl	%eax, 24(%esp)
	cmpl	$0, 24(%esp)
	jg	.L4
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
	jmp	.L7
.L9:
	movl	12(%ebp), %eax
	subl	$1, %eax
	cmpl	-16(%ebp), %eax
	jle	.L8
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movb	%dl, (%eax)
	addl	$1, -12(%ebp)
.L8:
	addl	$1, -16(%ebp)
.L7:
	call	getchar
	movl	%eax, -20(%ebp)
	cmpl	$-1, -20(%ebp)
	jne	.L9
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	movl	-16(%ebp), %eax
	leave
	ret
	.size	getline_1, .-getline_1
.globl strindex
	.type	strindex, @function
strindex:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$-1, -16(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L12
.L16:
	movl	-12(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L13
.L14:
	addl	$1, -8(%ebp)
	addl	$1, -4(%ebp)
.L13:
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %edx
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	je	.L14
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L15
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
.L15:
	addl	$1, -12(%ebp)
.L12:
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L16
	movl	-16(%ebp), %eax
	leave
	ret
	.size	strindex, .-strindex
.globl itob
	.type	itob, @function
itob:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -20(%ebp)
.L21:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	16(%ebp)
	movl	%edx, %eax
	sarl	$31, %eax
	xorl	%eax, %edx
	movl	%edx, -12(%ebp)
	subl	%eax, -12(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	addl	12(%ebp), %edx
	cmpl	$9, -12(%ebp)
	jg	.L19
	movl	-12(%ebp), %eax
	addl	$48, %eax
	jmp	.L20
.L19:
	movl	-12(%ebp), %eax
	addl	$87, %eax
.L20:
	movb	%al, (%edx)
	addl	$1, -16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	16(%ebp)
	movl	%eax, 8(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L21
	cmpl	$16, 16(%ebp)
	jne	.L22
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$120, (%eax)
	addl	$1, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$48, (%eax)
	addl	$1, -16(%ebp)
.L22:
	cmpl	$0, -20(%ebp)
	jns	.L23
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$45, (%eax)
	addl	$1, -16(%ebp)
.L23:
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	reverse
	leave
	ret
	.size	itob, .-itob
.globl itobw
	.type	itobw, @function
itobw:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -20(%ebp)
.L28:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	16(%ebp)
	movl	%edx, %eax
	sarl	$31, %eax
	xorl	%eax, %edx
	movl	%edx, -12(%ebp)
	subl	%eax, -12(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	addl	12(%ebp), %edx
	cmpl	$9, -12(%ebp)
	jg	.L26
	movl	-12(%ebp), %eax
	addl	$48, %eax
	jmp	.L27
.L26:
	movl	-12(%ebp), %eax
	addl	$87, %eax
.L27:
	movb	%al, (%edx)
	addl	$1, -16(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	idivl	16(%ebp)
	movl	%eax, 8(%ebp)
	cmpl	$0, 8(%ebp)
	jne	.L28
	cmpl	$16, 16(%ebp)
	jne	.L29
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$120, (%eax)
	addl	$1, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$48, (%eax)
	addl	$1, -16(%ebp)
.L29:
	cmpl	$0, -20(%ebp)
	jns	.L31
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$45, (%eax)
	addl	$1, -16(%ebp)
	jmp	.L31
.L32:
	movl	-16(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$32, (%eax)
	addl	$1, -16(%ebp)
.L31:
	movl	-16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jle	.L32
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	reverse
	leave
	ret
	.size	itobw, .-itobw
.globl reverse
	.type	reverse, @function
reverse:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -12(%ebp)
	jmp	.L35
.L36:
	addl	$1, -12(%ebp)
.L35:
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L36
	subl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	jne	.L37
	subl	$1, -12(%ebp)
.L37:
	movl	$0, -8(%ebp)
	jmp	.L38
.L39:
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
.L38:
	movl	-8(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	.L39
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
.L42:
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
	jne	.L42
	cmpl	$0, -16(%ebp)
	jns	.L43
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	$45, (%eax)
	addl	$1, -12(%ebp)
.L43:
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
.globl expand
	.type	expand, @function
expand:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L46
.L50:
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$45, %al
	jne	.L47
	movl	-8(%ebp), %eax
	addl	$1, %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-9(%ebp), %al
	jl	.L47
	addl	$1, -8(%ebp)
	jmp	.L48
.L49:
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	-9(%ebp), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
	addb	$1, -9(%ebp)
.L48:
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	-9(%ebp), %al
	jg	.L49
	jmp	.L46
.L47:
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	-9(%ebp), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
.L46:
	movl	-8(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, -9(%ebp)
	cmpb	$0, -9(%ebp)
	setne	%al
	addl	$1, -8(%ebp)
	testb	%al, %al
	jne	.L50
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	leave
	ret
	.size	expand, .-expand
.globl escape
	.type	escape, @function
escape:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L53
.L60:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	$92, %eax
	je	.L58
	cmpl	$92, %eax
	jg	.L54
	cmpl	$9, %eax
	je	.L56
	cmpl	$10, %eax
	je	.L57
	cmpl	$8, %eax
	je	.L55
	jmp	.L54
.L57:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$110, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L59
.L56:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$116, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L59
.L58:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L59
.L55:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$98, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L59
.L54:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-8(%ebp), %edx
	addl	12(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
.L59:
	addl	$1, -8(%ebp)
.L53:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L60
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	leave
	ret
	.size	escape, .-escape
.globl unescape
	.type	unescape, @function
unescape:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	-4(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L63
.L74:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	$92, %eax
	jne	.L76
.L65:
	addl	$1, -8(%ebp)
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	cmpl	$110, %eax
	je	.L69
	cmpl	$110, %eax
	jg	.L71
	cmpl	$92, %eax
	je	.L67
	cmpl	$98, %eax
	je	.L68
	jmp	.L66
.L71:
	cmpl	$116, %eax
	je	.L70
	jmp	.L66
.L69:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$10, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L72
.L70:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$9, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L72
.L67:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L72
.L68:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$8, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L72
.L66:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$92, (%eax)
	addl	$1, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-8(%ebp), %edx
	addl	12(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
	jmp	.L73
.L72:
	jmp	.L73
.L76:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movl	-8(%ebp), %edx
	addl	12(%ebp), %edx
	movzbl	(%edx), %edx
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
.L73:
	addl	$1, -8(%ebp)
.L63:
	movl	-8(%ebp), %eax
	addl	12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L74
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movb	$0, (%eax)
	leave
	ret
	.size	unescape, .-unescape
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-4)"
	.section	.note.GNU-stack,"",@progbits
