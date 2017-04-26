.section .data
	.globl output
	output:
	.string "maxval: %d\n"
	.globl output2
	output2:
	.string "%5d - %5d : " 
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
	movl -72(%ebp, %eax, 4), %ebx
	addl $1, %ebx
	movl %ebx, -72(%ebp, %eax, 4)	
	jmp l0
l1:
	movl -28(%ebp), %eax
	addl $1, %eax
	movl %eax, -28(%ebp)
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
	jng inc_jmp
	movl -72(%ebp, %ebx, 4), %eax
	movl %eax, -24(%ebp)
inc_jmp:
	movl -8(%ebp), %eax
	addl $1, %eax
	movl %eax, -8(%ebp)
cnd2:
	movl -8(%ebp), %eax
	cmpl MAXWORD, %eax
	jl for2
	pushl -24(%ebp)
	pushl $output
	call printf
	addl $8, %esp
	movl $1, %eax
	movl %eax, -8(%ebp)
	jmp cnd3
for3:
	movl -8(%ebp), %ebx
	movl -72(%ebp, %ebx, 4), %eax
	pushl %eax
	pushl -8(%ebp)
	pushl $output2
	call printf
	addl $12, %esp
	movl -8(%ebp), %ebx
	movl -72(%ebp, %ebx, 4), %eax
	cmpl $0, %eax
	jng p_else
	movl -8(%ebp), %ebx
	movl -72(%ebp, %ebx, 4), %eax
	movl %eax, -20(%ebp)
	cmpl $0, %eax
	jg outp_if
	movl $1, -20(%ebp)
	jmp outp_if	
p_else:
	movl $0, -20(%ebp)
outp_if:
	jmp cnd4
for4:
	pushl $42
	call putchar
	addl $4, %esp
	movl -20(%ebp), %eax
	subl $1, %eax
	movl %eax, -20(%ebp)
cnd4:
	movl -20(%ebp), %eax
	cmpl $0, %eax
	jg for4
	pushl $10
	call putchar
	addl $4, %esp
	movl -8(%ebp), %eax
	addl $1, %eax
	movl %eax, -8(%ebp)			
cnd3:
	movl -8(%ebp), %eax
	cmpl MAXWORD, %eax
	jl for3			
	movl %ebp, %esp
	popl %ebp
	movl $1, %eax
	call exit
