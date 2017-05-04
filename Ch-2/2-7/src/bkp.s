.include "asm/header.s"
.include "asm/linux.s"
.section .rodata
	msg_p1:
	.string "The modified bit pattern is %x\n"
.section .text
.globl	main
.type	main, @function
.equ	result,	loc1
main:
	pushl %ebp
	movl %esp,%ebp
	andl $-16, %esp
	subl $16, %esp
	movl $0, loc1(%ebp)
	movl $0x47, arg1(%esp)
	movl $4, arg2(%esp)
	movl $3, arg3(%esp)
	call invert
	movl %eax, result(%ebp)
	movl $msg_p1, arg1(%esp)
	movl %eax, arg2(%esp)
	call printf
	movl $0, arg1(%esp)
	call exit
.globl	invert
.type	invert, @function
.equ	x, p1
.equ	p, p2
.equ	n, p3
invert:
	pushl %ebp
	movl %esp, %ebp
	movl $0, %ebx
	not %ebx
	movb p3(%ebp), %cl
	shll %cl, %ebx
	not %ebx
	movl p2(%ebp), %eax
	addl $1, %eax
	subl p3(%ebp), %eax
	movl %eax, %ecx
	shll %cl, %ebx
	xorl p1(%ebp), %ebx
	movl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret	
