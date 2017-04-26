.section .data
	.globl str
	.type str, @object
	.align 4
	.size str, 4
	str:
	.string "123"
.section .rodata
	msg_p2:	
	.string "Hello\n"
	msg_p1:
	.string "The integer is %d\n"
.section .text
.globl main
.type main, @function
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movl $0, -4(%ebp)
	movl $str, (%esp)
	call myatoi
	movl %eax, -4(%ebp)
	movl %eax, 4(%esp)
	movl $msg_p1, (%esp)
	call printf
	movl $0, (%esp)
	call exit
.globl myatoi
.type myatoi, @function
myatoi:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -8(%ebp)
	movl $0, -4(%ebp)
	jmp cnd
for:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	xor %ebx, %ebx
	movb (%edx, %ecx, 1), %bl
	subl $48, %ebx
	movl -8(%ebp), %eax
	movl $10, %ecx
	mull %ecx
	addl %eax, %ebx
	movl %ebx, -8(%ebp)
	addl $1, -4(%ebp)
cnd:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	xor %eax, %eax
	movb (%edx, %ecx, 1), %al
	cmpl $48, %eax
	jnge out1
	cmpl $57, %eax
	jle for
out1:
	movl -8(%ebp), %eax	
	movl %ebp, %esp
	popl %ebp
	ret
	 
