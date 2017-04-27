.equ IN, 1
.equ OUT, 0

.section .data
	.globl s
	.type s, @object
	.size s, 6
	.align 4
	s:
	.string "0x123"
	.global flag
	.type flag, @object
	.size flag, 4
	.align 4
	flag:
	.int 0
.section .text
.globl main
.type main, @function
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movl $s, (%esp)
	call myhtoi
	movl %eax, -4(%ebp)
	movl -4(%ebp), %ebx
	movl %ebx, 4(%esp)
	movl $msg_p1, (%esp)
	call printf
	movl $0, (%esp)
	call exit
.globl myhtoi
.type myhtoi, @function
myhtoi:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -8(%ebp)
	movl $0, -4(%ebp)
	jmp cnd1
for1:
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $30, %al
	jne if2
	movl flag, %eax
	cmpl $0, %eax
	jne if2
	addl $1, -4(%ebp)
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $78, %al
	je flgin
	cmpb $58, %al
	jne if2
flgin:
	movl $1, flag
if2:
	movl flag, %eax
	cmpl $1, %eax
	jne outif2
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $30, %al
	jnge elif1
	cmpb $39, %al
	jnle elif1
	subb $30, %al
	movzx %al, %ebx
	movl -8(%ebp), %eax
	movl $16, %edx
	mull %edx
	addl %ebx, %eax
	movl %eax, -8(%ebp)
	jmp outif2
elif1:
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $41, %al
	jnge elif2
	cmpb $46, %al
	jnle elif2
	subb $41, %al
	movzx %al, %ebx
	movl -8(%ebp), %eax
	movl $16, %edx
	mull %edx
	addl %ebx, %eax
	addl $10, %eax
	movl %eax, -8(%ebp)
	jmp outif2
elif2:
	xor %eax, %eax
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $61, %al
	jnge outif2
	cmpb $66, %al
	jnle outif2
	subb $61, %al
	movzx %al, %ebx
	movl -8(%ebp), %eax
	movl $16, %edx
	mull %edx
	addl %ebx, %eax
	addl $10, %eax
	movl %eax, -8(%ebp)
outif2:
	addl $1, -4(%ebp)
cnd1:
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $30, %al
	jnge out1
	cmpb $39, %al
	jle for
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $41, %al
	jnge out1
	cmpb $46, %al
	jle for
	movl 8(%ebp), %edx
	movl -4(%ebp), %ecx
	movb (%edx, %ecx, 1), %al
	cmpb $61, %al
	jnge out1
	cmpb $66, %al
	jle for
out1:
	movl -8(%ebp), %eax 
	movl %ebp, %esp
	popl %ebp
	ret
	
