.section .data
	.globl output
	output:
	.string "maxval: %d\n" 
.section .rodata
	.globl OUT
	OUT:
	.int 0
	.globl IN
	IN:
	.int 1
	.globl MAXWORD
	MAXWORD:
	.int 11
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $72, %esp
	movl OUT, %eax
	movl %eax, -16(%ebp)
	movl $0, -12(%ebp)
	movl $0, -28(%ebp)
	movl $0, -8(%ebp)
	jmp fill_zero
for_0:
	movl -8(%ebp), %eax
	movl $0, -72(%ebp, %eax, 4)
	addl $1, %eax
	movl %eax, -8(%ebp)
fill_zero:
	movl -8(%ebp), %eax
	cmpl MAXWORD, %eax
	jl for_0
	jmp cnd
for:
	movl -4(%ebp), %eax
	cmpl $32, %eax
	je outstate
	movl -4(%ebp), %eax
	cmpl $9, %eax
	je outstate
	movl -4(%ebp), %eax
	cmpl $10, %eax
	je outstate
	movl -16(%ebp), %eax
	cmpl OUT, %eax
	je h_elif
	jmp h_else
outstate:
	movl OUT, %eax
	movl %eax, -16(%ebp)
	movl -12(%ebp), %eax
	cmpl $0, %eax
	jng l0
	movl -12(%ebp), %eax
	cmpl MAXWORD, %eax
	jnl l1
	movl -28(%ebp), %eax
	addl $1, %eax
	movl %eax, -28(%ebp)
	jmp l0
l1:
	movl -72(%ebp, %eax, 4), %ebx
	addl $1, %ebx
	movl %ebx, -72(%ebp, %eax, 4)	
l0:
	movl $0, %eax
	movl %eax, -12(%ebp)	
	jmp cnd
h_elif:
	movl IN, %eax
	movl %eax, -16(%ebp) 
	movl $1, -12(%ebp)
	call putchar
	jmp cnd
h_else:
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	movl $0, -24(%ebp)
	movl $1, -8(%ebp)
	jmp cnd2
for2:
	movl -8(%ebp), %ebx
	movl -72(%ebp, %ebx, 4), %eax
	cmpl -24(%ebp), %eax
	jng cnd2
	movl -72(%ebp, %ebx, 4), %eax
	movl %eax, -24(%ebp)
cnd2:
	movl -8(%ebp), %eax
	cmpl MAXWORD, %eax
	jl for2
	pushl -24(%ebp)
	pushl $output
	call printf
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
