.section .data
	.globl output0
	output0:
	.string "Fahr	Celcius\n"
	.globl output
	output:
	.string "%5d %6d\n"
.section .text
	.globl main
	.type main, @function
	.globl celsius
	.type celsius, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, -8(%ebp)
	movl $300, -12(%ebp)
	movl $20, -16(%ebp)
	movl -8(%ebp), %eax
	movl %eax, -4(%ebp)
	jmp cnd
for:
	pushl -4(%ebp)	
	call celsius
	addl $4, %esp
	pushl %eax
	pushl -4(%ebp)
	pushl $output
	call printf
	addl $12, %esp
	movl -4(%ebp), %eax
	addl -16(%ebp), %eax
	movl %eax, -4(%ebp)
cnd:
	movl -4(%ebp), %eax
	cmpl -12(%ebp), %eax
	jle for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
celsius:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ebx
	subl $32, %ebx
	movl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret
