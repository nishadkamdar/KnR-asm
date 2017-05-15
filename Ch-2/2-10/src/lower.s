.include "/asm/header.s"
.include "/asm/linux.s"
.include "/asm/ascii.s"
.section .rodata
	msg_p1:
	.string	"The lower case of 'A' is %c\n"
.section .text
.globl main
.type main, @function
.equ c, loc1
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	$A, arg1(%esp)
	call 	lower
	movl	%eax, c(%ebp)
	movl	$msg_p1, arg1(%esp)
	movl 	%eax, arg2(%esp)
	call	printf	
	movl 	$0, arg1(%esp)
	call 	exit
.globl lower
.type lower, @function
.equ ch, loc1
.equ x,	p1
lower:
	pushl	%ebp
	movl 	%esp, %ebp
	subl 	$16, %esp
	movl	x(%ebp), %eax
	cmpl	$A, %eax
	jnge	else
	cmpl	$Z, %eax
	jnle	else
	addl	$a, %eax
	subl	$A, %eax
	movl	%eax, ch(%ebp)
	jmp 	out
else:	
	movl	%eax, ch(%ebp)
out:
	movl 	%ebp, %esp
	popl	%ebp
	ret
