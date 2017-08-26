.include /asm/header.s
.include /asm/linux.s
.section .rodata
	msg_p1:
	.string	""
.section .text
.globl	_itoa_
.type	_itoa_, @function
.equ 	n, p1
.equ	str, p2
.equ	i, loc1
_itoa_:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	$0, i(%ebp)
	movl	n(%ebp), %eax
	movl	$10, %ebx
	divl	%ebx
	cmpl	$0, %eax
	je	_itoa_else1
	movl	%eax, arg1(%esp)
	movl	str(%ebp), %edx
	movl	%edx, arg2(%esp)
	call	_itoa_
_itoa_else1:
	movl	n(%ebp), %eax
	cmpl	$0, %eax
	jnl	_itoa_else1_out
	movl	i(%ebp), %edx
	movl	str(%ebp), %ebx
	leal	(%ebx, %edx, 1), %eax
	movl	$'-', (%eax)
	addl	$1, i(%ebp)
_itoa_else1_out:
	movl	n(%ebp), %eax
	movl	$10, %ebx
	divl	%ebx
	addl	$'0', %eax
	movl	i(%ebp), %edx
	movl	str(%ebp), %ebx
	leal	(%ebx, %edx, 1), %ecx
	movl	%eax, (%ecx)
	addl	$1, i(%ebp)
	movl	i(%ebp), %edx
	movl	str(%ebp), %ebx
	leal	(%ebx, %edx, 1), %ecx
	movl	$0, (%ecx)
	movl	%ebp, %esp
	popl	%ebp
	ret
