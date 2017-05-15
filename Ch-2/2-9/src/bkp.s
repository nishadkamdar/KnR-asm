.include "asm/header.s"
.include "asm/linux.s"
.section .rodata
	msg_p1:
	.string "The number of 1s in the number is %d\n"
.section .text
.globl main
.type main, @function
.equ i,	loc1
.equ x, loc2
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp
	movl	0xf0, loc2(%ebp)	
	movl 	0xf0, (%esp)
	call	bitcount
	movl	%eax, loc1(%ebp)
	movl	msg_p1, arg1(%esp)
	movl	%eax, arg2(%esp)
	movl	$0, arg1(%esp)
	call	exit
.globl bitcount
.type bitcount, @function
.equ x, p1
.equ cnt, loc1
bitcount:
	pushl	%ebp
	movl	%esp, %ebp
	subl 	$16, %esp
	movl 	$0, cnt(%ebp)
	jmp	cnd
while:
	addl 	$1, cnt(%ebp)
cnd:
	movl 	x(%ebp), %ebx
	movl	%ebx, %ecx
	subl	$1, %ebx
	andl	%ebx, %ecx
	cmpl 	$0, %ecx
	jne	while
	movl 	cnt(%ebp), %eax
	movl 	%ebp, %esp
	popl	%ebp
	ret
