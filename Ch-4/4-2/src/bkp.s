.include "/asm/ascii.s"
.include "/asm/header.s"
.include "/asm/linux.s"
.section .data
	.globl d1
	.type d1, @object
	.size d1, 8
	.align 8
	d1:
	.double 0.0
	.globl d2
	.type d2, @object
	.size d2, 8
	.align 8
	d2:
	.double 10.0
	.globl d3
	.type d3, @object
	.size d3, 8
	.align 8
	d3:
	.double 1.0
.section .rodata
	inp_str:
	.string	"123.456"
	msg_p1:
	.string "The floating point value is: %f\n"
.section .text
.globl	main
.type	main, @function
.equ	floatval, -8
main:
	pushl	%ebp
	movl 	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$inp_str, arg1(%esp)
	call 	atof_1
	fstl	floatval(%ebp)
	movl	$msg_p1, arg1(%esp)
	fstl	arg2(%esp)
	call 	printf
	movl	$EXIT_SUCCESS, arg1(%esp)
	call 	exit
.globl	atof_1
.type 	atof_1, @function
.equ	s, p1
.equ	val, -8
.equ	power, -16
.equ	exp, -20
.equ	i, -24
.equ	sign, -28
.equ	temp, -32
atof_1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$64, %esp
	movl	$0, i(%ebp)
	jmp 	cndfor1
for1:
	addl	$1, i(%ebp)
cndfor1:
	xor 	%eax, %eax
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	movl 	%eax, arg1(%esp)
	call 	isspace
	cmpl	$0, %eax
	jne	for1
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'-', %al
	jne	false_ter_op
	movl	$-1, sign(%ebp)
	jmp 	out_ter_op
false_ter_op:
	movl	$1, sign(%ebp)
out_ter_op:
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'-', %al
	je	true_if1
	cmpb	$'+', %al
	jne	out_if1
true_if1:
	addl	$1, i(%ebp)
out_if1:
	fldl	d1
	fstpl	val(%ebp)
	jmp 	cndfor2
for2:
	xorl	%eax, %eax
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	subb	$'0', %al
	movl	%eax, temp(%ebp)
	fldl	d2
	fldl	val(%ebp)
	fmulp
	fild	temp(%ebp)
	faddp
	fstpl	val(%ebp)
	addl	$1,  i(%ebp)
cndfor2:
	xorl	%eax, %eax
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	for2
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'.', %al
	jne	outif2
	addl	$1, i(%ebp)
outif2:
	fldl	d3
	fstpl	power(%ebp)
	jmp 	cndfor3
for3:
	xorl	%eax, %eax
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	subb	$'0', %al
	movl	%eax, temp(%ebp)
	fldl	d2
	fldl	val(%ebp)
	fmulp
	fild	temp(%ebp)
	faddp
	fstpl	val(%ebp)
	fldl	d2
	fmull	power(%ebp)
	fstl	power(%ebp)
	addl	$1,  i(%ebp)
cndfor3:
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	movb	%al, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	for3
	fldl	power(%ebp)
	fldl 	val(%ebp)
	fdivp
	fimul	sign(%ebp)
	fstl	val(%ebp)
	movl 	%ebp, %esp
	popl	%ebp
	ret

