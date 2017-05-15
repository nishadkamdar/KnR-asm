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
	call rightrot
	movl %eax, result(%ebp)
	movl $msg_p1, arg1(%esp)
	movl %eax, arg2(%esp)
	call printf
	movl $0, arg1(%esp)
	call exit
.globl	rightrot
.type	rightrot, @function
.equ	x, p1
.equ	n, p2
.equ	wl, loc1
rightrot:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	call wordlength
	movl %eax, wl(%ebp)
	movl $0, %ebx
	not %ebx
	movb n(%ebp), %cl
	shll %cl, %ebx
	not %ebx
	andl x(%ebp), %ebx
	movl wl(%ebp), %eax
	subl n(%ebp), %eax
	movl %eax, %ecx
	shll %cl, %ebx 
	movl $0, %eax
	not %eax
	movb n(%ebp), %cl
	shll %cl, %eax
	andl x(%ebp), %eax
	movb n(%ebp), %cl
	shrl %cl, %eax
	orl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret
.globl	wordlength
.type	wordlength, @function
.equ	i, loc1
.equ	v, loc2
wordlength:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, i(%ebp)
	movl $0, %eax
	not %eax
	movl %eax, v(%ebp)
	jmp cnd
for:
	shll v(%ebp)
	addl $1, i(%ebp)
cnd:
	movl v(%ebp), %eax
	cmpl $0, %eax
	jne for
	movl i(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret	
	
