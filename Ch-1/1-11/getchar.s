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
	subl $20, %esp
	movl $0, -4(%ebp)
	movl $0, -8(%ebp)
	movl $0, -12(%ebp)
	movl $0, -16(%ebp)
	movl OUT, %eax
	movl %eax, -20(%ebp)
	jmp cnd
for:
	movl -16(%ebp), %eax
	addl $1, %eax
	movl %eax, -16(%ebp)
	movl -4(%ebp), %eax
	cmpl $10, %eax
	jne l0
	movl -8(%ebp), %eax
	addl $1, %eax
	movl %eax, -8(%ebp)
l0:
	movl -4(%ebp), %eax
	cmpl $32, %eax
	je outstate
	movl -4(%ebp), %eax
	cmpl $9, %eax
	je outstate
	movl -4(%ebp), %eax
	cmpl $10, %eax
	je outstate
l1:
	movl -20(%ebp), %eax
	cmpl OUT, %eax
	jne cnd
	movl -20(%ebp), %eax
	movl IN, %eax
	movl %eax, -20(%ebp)
	movl -12(%ebp), %eax
	addl $1, %eax
	movl %eax, -12(%ebp)
	jmp cnd
outstate:
	movl -20(%ebp), %eax
	movl OUT, %eax
	movl %eax, -20(%ebp)
	jmp l1
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	pushl -16(%ebp)
	pushl -12(%ebp)
	pushl -8(%ebp)
	pushl $output
	call printf
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
