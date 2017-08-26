.include "/asm/header.s"
.include "/asm/linux.s"
.equ	NUMBER, 0
.equ 	MAXOP, 100
.equ	MAXDPT, 1000
.equ	MAXCH,	100
.section .rodata
	msg_p1:
	.string	"value of the type is %d\n"
	msg_p2:
	.string "floatig val is %f\n"
	msg_p3:
	.string "The result is %f\n"
	msg_p4:
	.string "Invalid operand %s\n"
	msg_p5:
	.string "Stack overflow\n"
	msg_p6:
	.string "Stack Empty\n"
	msg_p7:
	.string	"Character overflow\n"
	msg_cval:
	.string "Value of c is %d\n"
	msg_getchar:
	.string "Value of getchar is %d\n"
	msg_ungetch_entry:
	.string "Value passed to ungetch is %d\n"
	msg_top:
	.string	"\t%.8g\n"
.section .data
	.globl 	val
	.type	val, @object
	.size	val, 800
	.align 	32
	val:
	.fill 800
	.globl  get
	.type	get, @object
	.size	get, 100
	.align 	4
	get:
	.fill 100
.section .bss
	.comm 	sp, 4, 4
	.comm	cp, 4, 4
.section .text
	.globl 	main
	.type 	main, @function
.equ	type, loc1
.equ 	op2, loc2
.equ	op1, -16
.equ 	sstr, -116
.equ	temp, -120
.equ	op3, -128
main:
	pushl 	%ebp
	movl 	%esp, %ebp
	andl	$-16, %esp
	subl	$144, %esp
		
	jmp	while_cnd1
while1:
	movl	$msg_p1, arg1(%esp)
	movl	type(%ebp), %eax
	movl	%eax, arg2(%esp)
	call 	printf
	
	movl	type(%ebp), %eax
	cmpl	$NUMBER, %eax
	je	case_num
	cmpl	$'+', %eax
	je	case_add
	cmpl	$'*', %eax
	je	case_mul
	cmpl	$'-', %eax
	je	case_sub
	cmpl	$'/', %eax
	je	case_div
	cmpl	$'%', %eax
	je	case_mod
	cmpl	$'?', %eax
	je	case_top
	cmpl	$'c', %eax
	je 	case_clear
	cmpl	$'d', %eax
	je	case_dup
	cmpl	$'s', %eax
	je	case_swap
	cmpl	$'\n', %eax
	je	case_nl
	movl	$msg_p4, arg1(%esp)
	leal	sstr(%ebp), %eax
	movl	%eax, arg2(%esp)
	call 	printf
	jmp	while_cnd1
case_num:
	leal	sstr(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	atof
	movl	$msg_p2, arg1(%esp)
	fstl 	arg2(%esp)
	call 	printf
	fstl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_add:
	call	pop
	fstl	op1(%ebp)
	call	pop
	faddl	op1(%ebp)
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_mul:
	call	pop
	fstl	op1(%ebp)
	call	pop
	fmull	op1(%ebp)
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_sub:
	call	pop
	fstl	op1(%ebp)
	call	pop
	fsubl	op1(%ebp)
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_div:
	call	pop
	fstl	op1(%ebp)
	call	pop
	fdivl	op1(%ebp)
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_top:
	call	pop
	fstl	op1(%ebp)
	fstl	arg2(%esp)
	movl	$msg_top, arg1(%esp)
	call 	printf
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_clear:
	call	clear
	jmp	while_cnd1
case_dup:
	call	pop
	fstl	op1(%ebp)
	fstl	arg1(%esp)
	call	push
	call	push
	jmp	while_cnd1
case_swap:
	call	pop
	fstpl	op1(%ebp)
	call	pop
	fstpl	op3(%ebp)
	fldl	op1(%ebp)
	fstpl	arg1(%esp)
	call	push
	fldl	op3(%ebp)
	fstpl	arg1(%esp)
	call	push
	jmp	while_cnd1
case_nl:
	call	pop
	movl	$msg_p3, arg1(%esp)
	fstpl	arg2(%esp)
	call	printf
	jmp	while_cnd1
case_mod:
	call	pop
	fistl	op2(%ebp)
	call	pop
	fists	temp(%ebp)
	xorl	%edx, %edx
	movl	temp(%ebp), %eax
	divl	op2(%ebp)
	movl	%edx, arg1(%esp)
	filds	arg1(%esp)
	fstpl	arg1(%esp)
	call	push
while_cnd1:
	leal	sstr(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	getop
	movl	%eax, type(%ebp)
	cmpl	$-1, %eax
	jne	while1
	movl	$EXIT_SUCCESS, arg1(%esp)
	call 	exit

	.globl 	push
	.type 	push, @function
.equ	f, p1
push:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	sp, %eax
	cmpl	$MAXDPT, %eax
	jnl	push_else
	movl	sp, %edx
	movl	$val, %ebx
	leal	(%ebx, %edx, 8), %eax
	fldl	f(%ebp)
	fstpl	(%eax)
	addl	$1, sp
	jmp 	push_if_out
push_else:
	movl	$msg_p5, arg1(%esp)
	call	printf
push_if_out:
	movl	%ebp, %esp
	popl	%ebp
	ret
	
	.globl 	pop
	.type 	pop, @function
pop:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	movl	sp, %eax
	cmpl	$0, %eax
	jng	pop_else
	subl	$1, sp
	movl	sp, %edx
	movl	$val, %ebx
	leal	(%ebx, %edx, 8), %eax
	fldl	(%eax)
	jmp	pop_if_out
pop_else:
	movl	$msg_p6, arg1(%esp)
	call 	printf
	fildl	-4(%ebp)
pop_if_out:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl 	getop
	.type 	getop, @function
.equ	c, loc1
.equ	i, loc2
.equ	s_getop, p1 
getop:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
while_cnd2:
	call 	getch
	#movl	$' ', %eax
	movl	%eax, c(%ebp)
	movl	%eax, arg2(%esp)
	movl	$msg_cval, arg1(%esp)
	call 	printf
	movl	c(%ebp), %eax
	movl	$0, %edx
	movl	s_getop(%ebp), %ebx
	leal	(%ebx, %edx, 1), %ecx
	movb 	%al, (%ecx)
	cmpb	$' ', %al
	je	while_cnd2
	cmpb	$'\t', %al
	je 	while_cnd2
	
	movl	$1, %edx
	movl	s_getop(%ebp), %ebx
	leal	(%ebx, %edx, 1), %ecx
	movb	$0, (%ecx)
	movl	$0, i(%ebp)
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne 	getop_if1_out
	movb	c(%ebp), %al
	cmpb	$'.', %al
	je	getop_if1_out
	cmpb	$'-', %al
	je 	getop_if1_out
	movl	c(%ebp), %eax
	jmp 	out_getop
getop_if1_out:
	movl	c(%ebp), %eax
	cmpb	$'-', %al
	jne	getop_if2_out
	call	getch
	movl	%eax, c(%ebp)
	movl	%eax, arg1(%esp)
	call 	isdigit
	cmpl	$0, %eax
	jne	getop_if3_in
	movl	c(%ebp), %eax
	cmpb	$'.', %al
	jne	getop_else1_in
getop_if3_in:
	addl	$1, i(%ebp)
	movl	i(%ebp), %edx
	movl	s_getop(%ebp), %ebx
	leal	(%ebx, %edx, 1), %eax
	movl	c(%ebp), %ebx
	movb	%bl, (%eax)
	jmp	getop_if2_out
getop_else1_in:
	movl	c(%ebp), %eax
	cmpb	$-1, %al
	je	getop_if4_out
	movl	c(%ebp), %ebx
	movl	%ebx, arg1(%esp)
	call	ungetch
getop_if4_out:
	movl	$'-', %eax
	jmp	out_getop
getop_if2_out:
	movl	c(%ebp), %ebx
	movl	%ebx, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	je	getop_if5_out
getop_while2_cnd:
	call	getch
	movl	%eax, c(%ebp)
	addl	$1, i(%ebp)
	movl	i(%ebp), %edx
	movl	s_getop(%ebp), %ebx
	leal	(%ebx, %edx,1), %ecx
	movb	%al, (%ecx)
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	getop_while2_cnd
getop_if5_out:
	movl	c(%ebp), %eax
	cmpb	$'.', %al
	jne	getop_if6_out
getop_while3_cnd:
	call	getch
	movl	%eax, c(%ebp)
	addl	$1, i(%ebp)
	movl	i(%ebp), %edx
	movl	s_getop(%ebp), %ebx
	leal	(%ebx, %edx,1), %ecx
	movb	%al, (%ecx)
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	getop_while3_cnd
getop_if6_out:
	movl	i(%ebp), %edx
	movl	s_getop(%ebp), %ebx
	movb	$0, (%ebx, %edx, 1)
	movl	c(%ebp), %eax
	cmpb	$-1, %al
	je	getop_if7_out
	movl	c(%ebp), %ebx
	movl	%ebx, arg1(%esp)
	call 	ungetch
getop_if7_out:
	movl	$NUMBER, %eax
out_getop:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl 	getch
	.type 	getch, @function
getch:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	cp, %eax
	cmpl	$0, %eax
	jng	getch_else1
	subl	$1, cp
	xorl	%eax, %eax
	movl	cp, %edx
	movl	$get, %ebx
	movb	(%ebx, %edx,1), %al
	jmp 	getch_out
getch_else1:
	xorl	%eax, %eax
	call	getchar
	movl	%eax, arg2(%esp)
	movl 	$msg_getchar, arg1(%esp)
	call	printf
	movl	arg2(%esp), %eax
getch_out:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl 	ungetch
	.type 	ungetch, @function
.equ 	ungetch_c, p1
ungetch:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	ungetch_c(%ebp) , %edx
	movl	%edx, arg2(%esp)
	movl	$msg_ungetch_entry, arg1(%esp)
	call 	printf
	movl	cp, %eax
	cmpl	$MAXCH, %eax
	jnge	ungetch_else1
	movl	$msg_p7, arg1(%esp)
	call	printf
	jmp 	ungetch_out
ungetch_else1:
	movl	cp, %edx
	movl	$get, %ebx
	leal	(%ebx, %edx, 1), %eax
	xorl	%ecx, %ecx
	movb	ungetch_c(%ebp), %cl
	movb	%cl, (%eax)
	addl	$1, cp	
ungetch_out:
	movl	%ebp, %esp
	popl	%ebp
	ret

	.globl	clear
	.type	clear, @function
clear:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$0, sp
	movl	%ebp, %esp
	popl	%ebp
	ret
