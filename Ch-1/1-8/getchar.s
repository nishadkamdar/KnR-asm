.section .data 
	.globl output
	output:
	.string "blanks: %d\ntabs: %d\nnewline: %d\n letter cnt: %d\n" 
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
	movl $0, -20(%ebp)
	jmp cnd
for:
	movl -4(%ebp), %eax
	cmpl $32, %eax
	je blank
	cmpl $9, %eax
	je tab
	cmpl $10, %eax
	je nl  
	jmp cnt	
blank:
	movl -8(%ebp), %edx
	addl $1, %edx
	movl %edx, -8(%ebp)
	jmp cnd
tab:
	movl -12(%ebp), %edx
	addl $1, %edx
	movl %edx, -12(%ebp)
	jmp cnd
nl:
	movl -16(%ebp), %edx
	addl $1, %edx
	movl %edx, -16(%ebp)
	jmp cnd
cnt:
	movl -20(%ebp), %edx
	addl $1, %edx
	movl %edx, -20(%ebp)
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	pushl -20(%ebp)
	pushl -16(%ebp)
	pushl -12(%ebp)
	pushl -8(%ebp)
	pushl $output
	call printf
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
