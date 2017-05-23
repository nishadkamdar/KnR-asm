.include "/asm/ascii.s"
.include "/asm/header.s"
.include "/asm/linux.s"
.equ MAXLINE, 1000
.section .rodata
	output1:
	.string "%s\n"
	output2:
	.string "%d, %s\n"
.section .text
	.globl getline
	.type getline, @function
	.globl copy
	.type copy, @function
	.globl main
	.type main, @function
.equ len, loc1
.equ max, loc2
.equ sstr, -1008
.equ tstr, -2008
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $2016, %esp
	movl $-11332244, arg1(%esp)
	leal tstr(%ebp), %eax 
	movl %eax, arg2(%esp)
	call itoa
	movl $output1, arg1(%esp)
	leal tstr(%ebp), %eax 
	movl %eax, arg2(%esp)
	call printf		
	movl $0, arg1(%esp)
	call exit
.globl itoa
.type itoa, @function
.equ sign, loc1
.equ i4, loc2
.equ integer, p1
.equ ascii_string, p2
itoa:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, i4(%ebp)
	movl integer(%ebp), %eax
	movl %eax, sign(%ebp)
	cmpl $0, %eax
	jnl do
	xorl %ebx, %ebx
	subl %eax, %ebx
	movl %ebx, %eax
	xorl %edx, %edx
	movl %eax, integer(%ebp)
do:
	movl integer(%ebp), %eax
	xorl %edx, %edx
	movl $10, %ebx
	divl %ebx
	addl $48, %edx
	movl i4(%ebp), %eax
	movl ascii_string(%ebp), %ebx
	leal (%ebx, %eax, 1), %ecx 
	movb %dl, (%ecx)
	addl $1, i4(%ebp)
while_itoa:
	movl integer(%ebp), %eax
	xorl %edx, %edx
	movl $10, %ebx
	divl %ebx
	movl %eax, integer(%ebp)
	cmpl $0, %eax
	jne  do
	movl sign(%ebp), %eax
	cmpl $0, %eax
	jnl itoa_if_out
	movl i4(%ebp), %eax
	movl ascii_string(%ebp), %ebx
	leal (%ebx, %eax, 1), %ecx
	movb $45, (%ecx)
	addl $1, i4(%ebp)
itoa_if_out:
	movl i4(%ebp), %eax
	movl ascii_string(%ebp), %ebx
	leal (%ebx, %eax, 1), %ecx
	movb $0, (%ecx)
	movl %ebp, %esp
	popl %ebp
	ret
.globl reverse
.type reverse, @function
reverse:
        pushl %ebp
        movl %esp, %ebp
        subl $16, %esp
        movl $0, -4(%ebp)
        movl $0, -8(%ebp)
        jmp cndrev
forrev:
        movl -4(%ebp), %eax
        addl $1, %eax
        movl %eax, -4(%ebp)
cndrev:
        movl 8(%ebp), %ebx
        movl -4(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        cmpb $0, (%eax)
        jne forrev
movl -4(%ebp), %eax
        subl $1, %eax
        movl %eax, -4(%ebp)
        movl 8(%ebp), %ebx
        movl -4(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        cmpb $10, (%eax)
        jne cndrev2
        movl -4(%ebp), %eax
        subl $1, %eax
        movl %eax, -4(%ebp)
        jmp cndrev2
forcnd2:
        movl 8(%ebp), %ebx
        movl -8(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        movb (%eax), %dl
        movb %dl, -9(%ebp)
        movl 8(%ebp), %ebx
        movl -4(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        movb (%eax), %dl
movb %dl, -9(%ebp)
        movl 8(%ebp), %ebx
        movl -4(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        movb (%eax), %dl
        movl 8(%ebp), %ebx
        movl -8(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        movb %dl, (%eax)
        movb -9(%ebp), %dl
        movl 8(%ebp), %ebx
        movl -4(%ebp), %ecx
        leal (%ebx, %ecx, 1), %eax
        movb %dl, (%eax)
        movl -4(%ebp), %eax
        subl $1, %eax
        movl %eax, -4(%ebp)
        movl -8(%ebp), %eax
        addl $1, %eax
        movl %eax, -8(%ebp)
cndrev2:
	movl -8(%ebp), %eax
        cmpl -4(%ebp), %eax
        jl forcnd2
        movl %ebp, %esp
        popl %ebp
        ret
