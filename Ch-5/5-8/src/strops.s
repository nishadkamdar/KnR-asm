.include "/asm/linux.s"
.include "/asm/header.s"
.section .rodata
	main_p1:
	.string "The new string is %s"
.section .data
	.globl	s
	.type	s, @object
	.size	s, 400
	.align	32
	s:
	.ascii	"Hello"
	.zero	394
	.globl	t
	.type	t, @object
	.size	t, 10
	.align	4
	t:
	.string	"world"
.section .text
	.globl 	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$s, arg1(%esp)
	movl	$t, arg2(%esp)
	movl	$6, arg3(%esp)
	call	strncpy
	movl	$s, arg1(%esp)
	call 	printf
	movl	$0, %eax
	call	exit
	.globl	strncpy
	.type	strncpy, @function
.equ 	str_s, p1
.equ	str_t, p2
.equ	n, p3
strncpy:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	jmp	strncpy_while1_cnd
strncpy_while1:
	subl	$1, n(%ebp)
	movl	str_t(%ebp), %ebx
	movl	str_s(%ebp), %eax
	movb	(%ebx), %dl
	movb	%dl, (%eax)
	addl	$1, %ebx
	movl	%ebx, str_t(%ebp)
	addl	$1, %eax
	movl	%eax, str_s(%ebp)
strncpy_while1_cnd:
	movl	str_t(%ebp), %ebx
	movb	(%ebx), %al
	cmpb	$'\0', %al
	je	strncpy_while1_out
	movl	n(%ebp), %eax
	cmpl	$0, %eax
	jg	strncpy_while1
strncpy_while1_out:
	jmp	strncpy_while2_cnd
strncpy_while2:
	subl	$1, n(%ebp)
	movl	str_s(%ebp), %eax
	movb	$'\0', (%eax)
	addl	$1, %eax
	movl	%eax, str_s(%ebp)
strncpy_while2_cnd:
	movl	n(%ebp), %eax
	cmpl	$0, %eax
	jg	strncpy_while2
	movl	%ebp, %esp
	popl 	%ebp
	ret

