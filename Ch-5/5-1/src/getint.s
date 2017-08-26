.include "/asm/linux.s"
.include "/asm/header.s"
.equ 	SIZE, 10
.equ	BUFSIZE, 100
.section .rodata
	main_p1:
	.string	"arr[%d] = %d\n"
	ungetch_p1:
	.string "ungetch: too many characters\n"
.section .data
	.globl	buff
	.type	buff, @object
	.size	buff, 400
	.align	4
	buff:
	.fill	400
	.globl	cp
	.type 	cp, @object
	.size	cp, 4
	.align 	4
	cp:
	.int 	0
.section .text
	.globl	main
	.type	main, @function
.equ	n, loc1
.equ	i, loc2
.equ	arr, -48
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$80, %esp
	movl	$0, n(%ebp)
	jmp	main_for1_cnd
main_for1:
	addl	$1, n(%ebp)
main_for1_cnd:
	leal	arr(%ebp), %ebx
	movl	n(%ebp), %edx
	leal	(%ebx, %edx, 4), %eax
	movl	%eax, arg1(%esp)
	call	getint
	cmpl	$-1, %eax
	jne	main_for1
	movl	$0, i(%ebp)
	jmp	main_for2_cnd
main_for2:
	movl	$main_p1, arg1(%esp)
	movl	i(%ebp), %ebx
	movl 	%ebx, arg2(%esp)
	movl	i(%ebp), %edx
	leal	arr(%ebp), %ebx
	movl	(%ebx, %edx, 4), %eax
	movl	%eax, arg3(%esp)
	call	printf
	addl	$1, i(%ebp)
main_for2_cnd:
	movl	i(%ebp), %eax
	cmpl	n(%ebp), %eax
	jl	main_for2
	movl	$0, arg1(%esp)
	call	exit
	.globl	getint
	.type	getint, @function
.equ	pn, p1
.equ	c, loc1
.equ	d, loc2
.equ	sign, loc3
.equ	temp_c, loc4
getint:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$32, %esp
getint_while1:
	call	getch
	movl	%eax, c(%ebp)
	movl	%eax, arg1(%esp)
	call	isspace
	cmpl	$0, %eax
	jne	getint_while1
	
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	getint_if1_out
	cmpl	$-1, c(%ebp)
	je	getint_if1_out
	cmpl	$'-', c(%ebp)
	je	getint_if1_out
	cmpl	$'+', c(%ebp)
	je	getint_if1_out
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	ungetch
	movl	$0, %eax
	jmp	getint_out
getint_if1_out:
	movl	c(%ebp), %eax
	cmpl	$'-', %eax
	jne	getint_ter_else
	movl	$-1, sign(%ebp)
	jmp	getint_ter_out
getint_ter_else:
	movl	$1, sign(%ebp)
getint_ter_out:
	movl	c(%ebp), %eax
	cmpl	$'+', %eax
	je	getint_if2_in
	cmpl	$'-', %eax
	jne	getint_if2_out
getint_if2_in:
	movl	c(%ebp), %eax
	movl	%eax, d(%ebp)
	call	getch
	movl	%eax, c(%ebp)
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	getint_if2_out
	movl	c(%ebp), %eax
	movl	$-1, %eax
	je	getint_if4_out
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call 	ungetch
getint_if4_out:
	movl	d(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	ungetch
	movl	d(%ebp), %eax
	jmp	getint_out
getint_if2_out:
	movl	pn(%ebp), %eax
	movl	$0, (%eax)
	jmp	getint_for1_cnd
getint_for1:
	movl	c(%ebp), %eax
	subl	$'0', %eax
	movl	%eax, temp_c(%ebp)
	movl	pn(%ebp), %ebx
	movl	(%ebx), %eax
	
	movl	$10, %ecx
	mull	%ecx
	
	addl	temp_c(%ebp), %eax
	movl	%eax, (%ebx)
	call	getch
	movl	%eax, c(%ebp)
getint_for1_cnd:
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	isdigit
	cmpl	$0, %eax
	jne	getint_for1
	
	movl	pn(%ebp), %ecx
	movl	(%ecx), %eax
	movl	sign(%ebp), %ebx
	mull	%ebx
	movl	%eax, (%ecx)
	
	movl	c(%ebp), %eax
	cmpl	$-1, %eax
	je	getint_if6_out
	movl	c(%ebp), %eax
	movl	%eax, arg1(%esp)
	call	ungetch
getint_if6_out:
	movl	c(%ebp), %eax
getint_out:
	movl	%ebp, %esp
	popl	%ebp
	ret
        
	.globl  getch
        .type   getch, @function
getch:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $16, %esp
        movl    cp, %eax
        cmpl    $0, %eax
        jng     getch_else1
        subl    $1, cp
        xorl    %eax, %eax
        movl    cp, %edx
        movl    $buff, %ebx
        movb    (%ebx, %edx,1), %al
        jmp     getch_out
getch_else1:
	xorl    %eax, %eax
	call    getchar
getch_out:
	movl    %ebp, %esp
	popl    %ebp
	ret

	.globl  ungetch
	.type   ungetch, @function
.equ    ungetch_c, p1
ungetch:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $16, %esp
	movl    cp, %eax
	cmpl    $BUFSIZE, %eax
	jnge    ungetch_else1
	movl    $ungetch_p1, arg1(%esp)
	call    printf
	jmp     ungetch_out
ungetch_else1:
	movl    cp, %edx
	movl    $buff, %ebx
	leal    (%ebx, %edx, 1), %eax
	xorl    %ecx, %ecx
	movb    ungetch_c(%ebp), %cl
	movb    %cl, (%eax)
	addl    $1, cp
ungetch_out:
	movl    %ebp, %esp
	popl    %ebp
	ret


