.include "/asm/header.s"
.include "/asm/linux.s"
.section .rodata
	msg_p1:
	.string	"Element found at position %d\n"
	msg_p2:
	.string	"Element not found\n"
.section .data
	.globl v
	.type v, @object
	.size v, 40
	.align 4
	v:
 	.int 21,32,42,53,64,72,77,83,94,111
.section .text
.globl main
.type main, @function
.equ result, loc1
main:
	pushl 	%ebp
	movl 	%esp, %ebp
	andl 	$-16, %esp
	subl 	$16, %esp
	movl 	$0, result(%ebp)
	movl 	$111, arg1(%esp)
	movl 	$v, %eax
	movl	%eax, arg2(%esp)
	movl 	$10, arg3(%esp)
	call 	binsearch
	cmpl 	$-1, %eax
	je	else
	movl 	$msg_p1, arg1(%esp)
	movl	%eax, arg2(%esp)
	call 	printf
	jmp 	ex
else:
	movl	$msg_p2, arg1(%esp)
	call	printf
ex:
	movl 	$EXIT_SUCCESS, arg1(%esp)
	call 	exit
.globl binsearch
.type binsearch, @function
.equ x, p1
.equ a, p2
.equ n, p3
.equ low, loc1
.equ high, loc2
.equ mid, loc3
binsearch:
	pushl 	%ebp
	movl 	%esp, %ebp
	subl 	$16, %esp
	movl 	$0, low(%ebp)
	movl	n(%ebp), %eax
	subl 	$1, %eax
	movl	%eax, high(%ebp)
	addl	low(%ebp), %eax
	xorl	%edx, %edx
	movl	$2, %ebx
	div	%ebx
	movl	%eax, mid(%ebp)
	jmp cnd
while:
	movl	a(%ebp), %edx
	movl	mid(%ebp), %ebx
	movl	(%edx, %ebx, 4), %ecx
	movl	x(%ebp), %eax
	cmpl	%ecx, %eax
	jnl	else1
	movl	mid(%ebp), %ebx
	subl	$1, %ebx
	movl	%ebx, high(%ebp)
	jmp 	ifout
else1:
	movl 	mid(%ebp), %ebx
	addl	$1, %ebx
	movl	%ebx, low(%ebp)
ifout:
	movl	low(%ebp), %eax
	addl	high(%ebp), %eax
	movl	$2, %ebx
	xorl	%edx, %edx
	div	%ebx
	movl	%eax, mid(%ebp)		
cnd:
	movl 	low(%ebp), %eax
	cmpl	high(%ebp), %eax
	jnle	out
	movl	a(%ebp), %edx
	movl	mid(%ebp), %ebx
	movl	(%edx, %ebx, 4), %ecx
	movl	x(%ebp), %eax
	cmpl	%ecx, %eax
	jne	while
out:
	movl	a(%ebp), %edx
	movl	mid(%ebp), %ebx
	movl	(%edx, %ebx, 4), %ecx
	movl	x(%ebp), %eax
	cmpl	%ecx, %eax
	jne	else2
	movl	mid(%ebp), %eax
	jmp	exbs
else2:
	movl	$-1, %eax
exbs:
	movl 	%ebp, %esp
	popl 	%ebp
	ret
