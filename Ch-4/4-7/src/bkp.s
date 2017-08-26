.include "/asm/ascii.s"
.include "/asm/header.s"
.include "/asm/linux.s"
.equ MAXLINE, 1000
.section .rodata
	output1:
	.string "%s\n"
	output2:
	.string "%d, %s\n"
	pattern:
	.string "ould"
	msg_p1:
	.string	"Right most index is %d\n"
	msg_p2:
	.string "Pattern not found\n" 
.section .text
	.globl main
	.type main, @function
.equ len, loc1
.equ ind, loc2
.equ sstr, -1008
.equ tstr, -2008
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $2016, %esp
	jmp cnd1
for1:
	movl $output2, arg1(%esp)
	movl len(%ebp), %eax
	movl %eax, arg2(%esp)
	leal tstr(%ebp), %eax
	movl %eax, arg3(%esp)
	call printf
	leal tstr(%ebp), %eax
	leal $pattern, %ebx
	movl %eax, arg1(%esp)
	movl %ebx, arg2(%esp)
	call strindex
	movl %eax, ind(%ebp)
	cmpl $0, %eax
	jnl else_main
	movl $msg_p2, arg1(%esp)
	call printf
else_main:
	movl $msg_p1, arg1(%esp)
	movl ind(%ebp), %ebx
	movl %ebx, arg2(%esp)
	call printf
cnd1:
	movl $MAXLINE, %ebx
	leal tstr(%ebp), %eax
	movl %eax, arg1(%esp)
	movl %ebx, arg2(%esp)
	call getline
	movl %eax, -4(%ebp)
	cmpl $0, %eax
	jg for1
	movl $0, arg1(%esp)
	call exit
.globl getline
.type getline, @function
.equ c, loc1
.equ i, loc2
.equ j, loc3	
getline:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, j(%ebp)
	movl $0, i(%ebp)
	jmp cnd2
for2:
	movl 12(%ebp), %ebx
	subl $1, %ebx
	movl -8(%ebp), %eax	
	cmpl %ebx, %eax
	jnl out3
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl -4(%ebp), %ebx
	movl %ebx, (%eax)
	addl $1, j(%ebp)
out3:	
	addl $1, i(%ebp)
cnd2:
	call getchar
	movl %eax, c(%ebp)
	cmpl $-1, %eax	
	jne for2
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl $0, %ebx
	movl %ebx, (%eax)
	movl -8(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
.globl strindex
.type strindex, @function
.equ index, loc1
.equ i1, loc2
.equ j1, loc3
.equ k1, loc4
.equ str, p1
.equ pat, p2
strindex:
	pushl 	%ebp
	movl 	%esp, %ebp
	subl 	$16, %esp
	movl 	$-1, index(%ebp)
	movl 	0, i1(%ebp)
	jmp	strcnd
forstr:
	movl	i1(%ebp), %eax
	movl	%eax, j1(%ebp)
	movl 	$0, k1(%ebp)
	jmp 	strcnd2
forstr2:
	addl 	$1, j1(%ebp)
	addl 	$1, k1(%ebp)	
strcnd2:
	movl	k1(%ebp), %edx
	movl	pat(%ebp), %ebx
	xorl	%ecx, %ecx
	movb	(%ebx, %edx, 1), %cl
	movl	j1(%ebp), %edx
	movl	str(%ebp), %ebx
	xorl 	%eax, %eax
	movb	(%ebx, %edx, 1), %al
	cmpb 	%cl, %al
	je 	forstr2
	movl	k1(%ebp), %edx
	movl	pat(%ebp), %ebx
	xorl 	%eax, %eax
	movb	(%ebx, %edx, 1), %al
	cmpb	$0, %al
	jne	strcnd
	movl	i1(%ebp), %eax
	movl	%eax, index(%ebp)
strcnd:
	movl	i1(%ebp), %edx
	movl	str(%ebp), %ebx
	xorl 	%eax, %eax
	movb	(%ebx, %edx, 1), %al
	cmpb 	$0, %al
	jne 	forstr
	movl	index(%ebp), %eax 
	movl 	%ebp, %esp
	popl	%ebp
	ret	
