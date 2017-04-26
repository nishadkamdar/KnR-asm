.section .data 
	.globl tabout
	tabout:
	.string "\\t"
	.globl bspout
	bspout:
	.string "\\b"
	.globl bslout
	bslout:
	.string "\\\\" 
.section .text
	.globl main
	.type main, @function
	main:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, -4(%ebp)
	jmp cnd
for:
	movl -4(%ebp), %eax
	cmpl $9, %eax
	je tab
	cmpl $8, %eax
	je bspace
	cmpl $92, %eax
	je bslash  
	pushl -4(%ebp)
	call putchar
	addl $4, %esp
	jmp cnd	
tab:
	pushl $tabout
	call printf
	addl $4, %esp
	jmp cnd
bspace:
	pushl $bspout
	call printf
	addl $4, %esp
	jmp cnd
bslash:
	pushl $bslout
	call printf
	addl $4, %esp
	jmp cnd
cnd:	
	call getchar
	movl %eax, -4(%ebp)
	cmpl $-1, %eax
	jne for
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
