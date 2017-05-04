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
	subl $32, %esp
	movl $0, loc1(%ebp)
	movl $0x47, arg1(%esp)
	movl $4, arg2(%esp)
	movl $3, arg3(%esp)
	movl $0x12, arg4(%esp)
	call setbits
	movl %eax, result(%ebp)
	movl $msg_p1, arg1(%esp)
	movl %eax, arg2(%esp)
	call printf
	movl $0, arg1(%esp)
	call exit
.globl	setbits
.type	setbits, @function
.equ	x, p1
.equ	n, p2
.equ	p, p3
.equ	y, p4
setbits:
	pushl %ebp
	movl %esp, %ebp
	movl $0, %ebx
	not %ebx
	movb p2(%ebp), %cl
	shll %cl, %ebx
	not %ebx
	movl p3(%ebp), %eax
	addl $1, %eax
	subl p2(%ebp), %eax
	movl %eax, %ecx
	shll %cl, %ebx
	not %ebx
	andl p1(%ebp), %ebx
	movl $0, %eax
	not %eax
	movb p2(%ebp), %cl
	shll %cl, %eax
	not %eax
	andl p4(%ebp), %eax
	movl p3(%ebp), %edx
	addl $1, %edx
	subl p2(%ebp), %edx
	movl %edx, %ecx
	shll %cl, %eax
	orl %eax, %ebx
	movl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret	
