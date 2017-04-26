.section .rodata	
	msg_p1:
	.string "signed char min:	%4d,	max:%4d\n"
	msg_p2:
	.string "unsigned char min:	%4u,	max:%4u\n"
	msg_p3:
	.string "signed short min:	%6d,	max:%6d\n"
	msg_p4:
	.string "unsigned short min:	%6u,	max:%6u\n"
	msg_p5:
	.string "signed int min:	%11d,	max:%11d\n"
	msg_p6:
	.string "unsigned int min:	%11u,	max:%11u\n"
	msg_p7:
	.string "signed long min:	%11ld,	max:%11ld\n"
	msg_p8:
	.string "unsigned long min:	%11lu,	max:%11lu\n"
	msg_p9:
	.string "signed long long min: %20lld,	max:%20lld\n"
	msg_p10:
	.string "unsigned long long min: %20llu,max:%20llu\n"
.section .data
	.globl c
	.type c, @object
	.size c, 1
	.align 4
	c:
	.byte 0
	.globl s
	.type s, @object
	.size s, 2
	.align 4
	s:
	.value 0
	.globl i
	.type i, @object
	.size i, 4
	.align 4
	i:
	.int 0
	.globl l
	.type l, @object
	.size l, 4
	.align 4
	l:
	.long 0x0
	.globl ll
	.type ll, @object
	.size ll, 8
	.align 4
	ll:
	.long 0x0
	.long 0x0
.section .text
	.globl main
	main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $16, %esp
	movb $0, c
	xor %eax, %eax
	movb c, %al
	not %al
	shr %al
	movsx %al, %edx
	movl %edx, 8(%esp)				
	xor %ebx, %ebx
	movb $0, %bl
	subb %al, %bl
	subb $1, %bl
	movsx %bl, %edx
	movl %edx, 4(%esp)
	movl $msg_p1, (%esp)
	call printf
	movb $0, c
	xor %eax, %eax
	movb c, %al
	not %al
	movzx %al, %edx
	movl %edx, 8(%esp)	
	movl $0, 4(%esp)
	movl $msg_p2, (%esp)
	call printf
	movl $0, s
	xor %eax, %eax
	movw s, %ax
	not %ax
	shr %ax
	xor %ebx, %ebx
	subw %ax, %bx
	subw $1, %bx
	movsx %ax, %edx
	movsx %bx, %eax
	movl %edx, 8(%esp)
	movl %eax, 4(%esp)
	movl $msg_p3, (%esp)
	call printf
	xor %eax, %eax
	movw s, %ax
	not %ax
	movzx %ax, %edx
	movl %edx, 8(%esp)
	movl $0, 4(%esp)
	movl $msg_p4, (%esp)
	call printf
	movl $0, i
	movl i, %eax
	not %eax
	shr %eax
	movl $0, %ebx
	subl %eax, %ebx
	subl $1, %ebx
	movl %eax, 8(%esp)
	movl %ebx, 4(%esp)
	movl $msg_p5, (%esp)
	call printf
	movl i, %eax
	not %eax
	movl %eax, 8(%esp)	
	movl $0, 4(%esp)
	movl $msg_p6, (%esp)		 	
	call printf
	movl $0, l
	movl l, %eax
	not %eax
	shr %eax
	movl $0, %ebx
	subl %eax, %ebx
	subl $1, %ebx
	movl %eax, 8(%esp)
	movl %ebx, 4(%esp)
	movl $msg_p7, (%esp)
	call printf
	movl l, %eax
	not %eax
	movl %eax, 8(%esp)
	movl $0, 4(%esp)
	movl $msg_p8, (%esp)
	call printf	
	movl $0, (%esp)	
	call exit
	
