.section .rodata
	.globl output
	.type ouput, @object
	.size output, 14
	.align 4
	output:
	.string "Fahr	Celsius\n" 
	.globl output2
	.type output2, @object
	.align 4
	output2:
	.string "%3.0f	%6.1f\n"
	.globl dividend
	.type dividend, @object
	.size dividend, 4
	.align 4
	dividend:
	.float 5
	.globl divisor
	.type divisor, @object
	.size divisor, 4
	.align 4
	divisor:
	.float 9
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
	movl $300, -16(%ebp)
	movl $20, -20(%ebp)
	pushl $output
	call printf
	movl  -12(%ebp), %eax
	movl %eax, -4(%ebp)
	jmp cnd
for:
	movl -4(%ebp), %ebx
	subl  $32, %ebx
	movl $5, %eax
	movl $0, %edx
	divl divisor
	mull %ebx
	movl %eax, -8(%ebp)
	pushl -8(%ebp)
	pushl -4(%ebp)
	pushl $output2
	call printf
	movl -4(%ebp), %eax
	addl -20(%ebp), %eax
	movl %eax, -4(%ebp)
cnd:
	movl -4(%ebp), %eax
	cmpl -16(%ebp), %eax
	jle for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
