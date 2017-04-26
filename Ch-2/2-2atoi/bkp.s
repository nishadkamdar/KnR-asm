.section .data
	.globl str
	.type str, @object
	.align 4
	.size str, 4
	str:
	.string "123"
.section .roadta
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
	movl $0, -4(%ebp)
	movl $0, -8(%ebp)
	jmp cnd
for:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movl (%eds, %ecx, 4), %ebx
	subl $30, %ebx
	movl -8(%ebp), %ecx
	mull $10, %ecx
	addl %eax, %ebx
	movl %ebx, -8(%ebp)
	addl $1, -4(%ebp)
cnd:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movl (%edx, %ecx, 4), %eax
	cmpl $30, %eax
	jnge out1
	cmpl $39, %eax
	jle for
out1:
	movl -8(%ebp), %eax	
	movl %ebp, %esp
	popl %ebp
	ret
	 
