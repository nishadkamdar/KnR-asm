.section .rodata
	msg_p1:
	.string "The length of the string is %d\n"
.section .data
	.globl s
	.type s, @object
	.size s, 13
	.align 4
	s:
	.string "Hello, World"
.section .text
.globl main
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movl $0, -4(%ebp)
	movl $s, -8(%ebp)
	movl -8(%ebp), %eax
	movl %eax, (%esp)
	call strl
	movl %eax, -4(%ebp)
	movl %eax, 4(%esp)
	movl $msg_p1, (%esp)
	call printf	
	movl $0, (%esp)
	call exit	
.globl strl
.type strl, @function
strl:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -4(%ebp)
	jmp cnd_strl
for_strl:
	addl $1, -4(%ebp)
cnd_strl:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $0, %al
	jne for_strl
	addl $1, -4(%ebp)
	movl -4(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret	
