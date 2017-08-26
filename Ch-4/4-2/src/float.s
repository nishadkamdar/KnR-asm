.include "/asm/ascii.s"
.include "/asm/header.s"
.include "/asm/linux.s"
.section .data
	.globl value1
	.type value1, @object
	.size value1, 4
	.align 4
	value1:
	.float	12.345
	.globl value2
	.type value2, @object
	.size value2, 8
	.align 4
	value2:
	.float	12345.678900
.section .text
.globl 	main
.type 	main, @function
.equ	val, -8
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	finit
	movl	$3.14, val(%ebp)
	fldl	val(%ebp)
	flds	value1
	fldl	value2
	movl	$EXIT_SUCCESS, arg1(%esp)
	call 	exit
