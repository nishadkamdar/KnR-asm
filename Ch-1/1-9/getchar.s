.section .data 
	.globl output
	output:
	.string "blanks: %d\ntabs: %d\nnewline: %d\n letter cnt: %d\n" 
	.globl nonchar	
	.type nonchar, @object
	.size nonchar, 4
	.align 4
	nonchar:
	.int 12
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $8, %esp
	movl $0, -4(%ebp)
	movl nonchar, %ebx
	movl %ebx, -8(%ebp)
	jmp cnd
for:
	movl -4(%ebp), %eax
	cmpl $32, %eax
	je blank
	pushl -4(%ebp)
	call putchar
	addl $4, %esp
	jmp ulast
blank:
	movl -8(%ebp), %eax
	cmpl $32, %eax
	je ulast
cnd1:
	pushl -4(%ebp)
	call putchar
	addl $4, %esp
ulast:	
	movl -4(%ebp), %eax
	movl %eax, -8(%ebp)
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
