.section .data
	.globl output
	output:
	.string "lines: %d\n words: %d\n char: %d\n" 
	.globl OUT
	OUT:
	.int 0
	.globl IN
	IN:
	.int 1
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $0, -4(%ebp)
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
	movl $0, -16(%ebp)
	movl OUT, %eax
	movl %eax, -8(%ebp)
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
	movl -8(%ebp), %eax
	cmpl OUT, %eax
	je h_elif
	jmp h_else
outstate:
	movl -8(%ebp), %eax
	cmpl IN, %eax
	jne cnd
	pushl $10
	call putchar
	addl $4, %esp
	movl OUT, %eax
	movl %eax, -8(%ebp)
	jmp cnd
h_elif:
	movl IN, %eax
	movl %eax, -8(%ebp) 
	pushl -4(%ebp)
	call putchar
	addl $4, %esp
	jmp cnd
h_else:
	pushl -4(%ebp)
	call putchar
	addl $4, %esp
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
