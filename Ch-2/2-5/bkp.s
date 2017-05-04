.section .data
	.globl s1
	.type s1, @object
	.size s1, 6
	.align 4
	s1:
	.string "Hello"
	.globl s2
	.type s2, @object
	.size s, 3
	.align 4
	s2:	
	.string "He"
.section .rodata
	msg_p1:
	.string "Truncated string: %s\n"
.section .text
	.globl main
	.type main, @function
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movl $s2, 4(%esp)
	movl $s1, (%esp)
	call mysqz
	movl $s1, 4(%esp)
	movl $msg_p1, (%esp)
	call printf		
	movl $0, (%esp)
	call exit
	.globl mysqz
	.type mysq, @function
mysqz:	
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -4(%ebp)
	movl $0, -12(%ebp)
	jmp cnd1
for1:
	movl $0, -8(%ebp)
	jmp cnd2
for2:
	xor %eax, %eax
	movl 12(%ebp), %edx
	movl -8(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $0, %al
	jne outif
	xor %ebx, %ebx
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %bl
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -12(%ebp), %ecx
	movb %bl, (%edx, %ecx, 1)
	addl $1, -12(%ebp)
	jmp outfor2
outif:
	addl $1, -8(%ebp)	
cnd2:
	xor %eax, %eax
	xor %ebx, %ebx
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	movl 12(%ebp), %edx
	movl -8(%ebp), %ecx
	movb (%edx, %ecx, 1), %bl
	cmpb %bl, %al
	jne for2
outfor2:
	addl $1, -4(%ebp)
cnd1:
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $0, %al
	jne for1
	movl 8(%ebp), %edx
	movl -12(%ebp), %ecx
	movb $0, (%edx, %ecx, 1)
	movl %ebp, %esp
	popl %ebp
	ret		
