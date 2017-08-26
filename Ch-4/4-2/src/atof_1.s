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
	.string	"123.4E-4"
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
	
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'e', %al
	je	inif3
	cmpb	$'E', %al
	jne	outif3
inif3:
	addl	$1, i(%ebp)
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'-', %al
	jne	tr2_else
	movl 	$-1, sign(%ebp)
	jmp 	out_tr2
tr2_else:
	movl	$1, sign(%ebp)

out_tr2:
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	cmpb	$'+', %al
	je	inif4
	cmpb	$'-', %al
	jne	outif4
inif4:
	addl	$1, i(%ebp)

outif4:
	movl	$0, exp(%ebp)
	jmp	cndfor4
for4:
	xorl	%eax, %eax
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	subb	$'0', %al
	movl	%eax, %ecx
	movl	$10, %eax
	xorl	%edx, %edx
	mull	exp(%ebp)
	addl	%ecx, %eax
	movl	%eax, exp(%ebp)
	addl	$1, i(%ebp)
cndfor4:
	movl	i(%ebp), %edx
	movl	s(%ebp), %ebx
	movb	(%ebx, %edx, 1), %al
	movb	%al, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	for4
	cmpl	$1, sign(%ebp)
	jne	elseif5
	jmp	cndwhile2
while2:
	fldl	d2
	fldl	val(%ebp)
	fmulp
	fstpl	val(%ebp)
cndwhile2:
	movl	exp(%ebp), %eax
	subl	$1, exp(%ebp)
	cmpl	$0, %eax
	jg	while2
	jmp	outif5
elseif5:
	jmp	cndwhile1
while1:
	fldl	d2
	fldl	val(%ebp)
	fdivp
	fstpl	val(%ebp)
cndwhile1:
	movl	exp(%ebp), %eax
	subl	$1, exp(%ebp)
	cmpl	$0, %eax
	jg	while1
outif5:
	fldl	val(%ebp)
outif3:
	movl 	%ebp, %esp
	popl	%ebp
	ret

