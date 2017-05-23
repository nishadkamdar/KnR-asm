.include "/asm/ascii.s"
.include "/asm/header.s"
.include "/asm/linux.s"
.equ MAXLINE, 1000
.section .rodata
	output1:
	.string "%s\n"
	output2:
	.string "%d, %s\n"
.section .text
	.globl getline
	.type getline, @function
	.globl copy
	.type copy, @function
	.globl main
	.type main, @function
.equ len, loc1
.equ max, loc2
.equ sstr, -1008
.equ tstr, -2008
main:
	pushl %ebp
	movl %esp, %ebp
	andl $-16, %esp
	subl $2016, %esp
	movl $0, max(%ebp)
	jmp cnd1
for1:
	movl $output2, arg1(%esp)
	movl len(%ebp), %eax
	movl %eax, arg2(%esp)
	leal tstr(%ebp), %eax
	movl %eax, arg3(%esp)
	call printf
	leal tstr(%ebp), %eax
	leal sstr(%ebp), %ebx
	movl %eax, arg1(%esp)
	movl %ebx, arg2(%esp)
	call expand
	movl $output1, arg1(%esp)
	leal sstr(%ebp), %eax
	movl %eax, arg2(%esp)
	call printf
cnd1:
	movl $MAXLINE, %ebx
	leal tstr(%ebp), %eax
	movl %eax, arg1(%esp)
	movl %ebx, arg2(%esp)
	call getline
	movl %eax, -4(%ebp)
	cmpl $0, %eax
	jg for1
	movl $0, arg1(%esp)
	call exit
.equ c, loc1
.equ i, loc2
.equ j, loc3	
getline:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, j(%ebp)
	movl $0, i(%ebp)
	jmp cnd2
for2:
	movl 12(%ebp), %ebx
	subl $1, %ebx
	movl -8(%ebp), %eax	
	cmpl %ebx, %eax
	jnl out3
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl -4(%ebp), %ebx
	movl %ebx, (%eax)
	addl $1, j(%ebp)
out3:	
	addl $1, i(%ebp)
cnd2:
	call getchar
	movl %eax, c(%ebp)
	cmpl $-1, %eax	
	jne for2
	movl -12(%ebp), %ebx
	movl 8(%ebp), %ecx
	leal (%ecx, %ebx, 1), %eax
	movl $0, %ebx
	movl %ebx, (%eax)
	movl -8(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
.globl escape
.type escape, @function
.equ i1, loc1
.equ j1, loc2
.equ strout, p1
.equ strin, p2
escape:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, i1(%ebp)
	movl $0, j1(%ebp)
	jmp cndesc
foresc:
	movl i1(%ebp), %edx
	movl strin(%ebp), %ebx
	xorl  %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $newline, %al
	je casen
	cmpb $tab, %al
	je caset
	cmpb $backslash, %al
	je casebss
	cmpb $backspace, %al
	je caseb
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movl i1(%ebp), %edx
	movl strin(%ebp), %ebx
	xorl %ecx, %ecx
	movb (%ebx, %edx, 1), %cl 
	movb %cl, (%eax)
	addl $1, j1(%ebp)
	jmp swout
casen:
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $n, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	jmp swout
caset:
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $t, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	jmp swout
casebss:
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	jmp swout
caseb:
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $b, (%ebx, %edx, 1)
	addl $1, j1(%ebp)
swout:
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	movb $0, (%ebx, %edx, 1)
	addl $1, i1(%ebp) 		
cndesc:
	movl i1(%ebp), %edx
	movl strin(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $0, %al
	jne foresc	
	movl j1(%ebp), %edx
	movl strout(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $0, (%eax)
	movl %ebp, %esp
	popl %ebp
	ret
.globl unescape
.type unescape, @function
.equ i2, loc1
.equ j2, loc2
.equ strout1, p1
.equ strin1, p2
unescape:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, i2(%ebp)
	movl $0, j2(%ebp)
	jmp cndun
forun:
	movl i2(%ebp), %edx
	movl strin1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $92, %al	
	je casetop
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	xorl %ecx, %ecx
	movl i2(%ebp), %edx
	movl strin1(%ebp), %ebx
	movb (%ebx, %edx, 1), %cl
	movb %cl, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun
casetop:
	addl $1, i2(%ebp)
	movl i2(%ebp), %edx
	movl strin1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $n, %al
	je casen1
	cmpb $t, %al
	je caset1
	cmpb $92, %al
	je casebss1
	cmpb $b, %al
	je caseb1
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	movb $92, (%ebx, %edx, 1)
	addl $1, j2(%ebp)
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %eax, 1), %eax
	movl i2(%ebp), %edx
	movl strin1(%ebp), %ebx
	xorl %ecx, %ecx
	movb (%ebx, %edx, 1), %cl
	movb %cl, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun
casen1:
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $newline, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun 
caset1:
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $tab, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun 
casebss1:
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $backslash, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun 
caseb1:
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $backspace, (%eax)
	addl $1, j2(%ebp)
	addl $1, i2(%ebp)
	jmp cndun 
cndun:
	movl i2(%ebp), %edx
	movl strin1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $0, %al
	jne forun
	movl j2(%ebp), %edx
	movl strout1(%ebp), %ebx
	movb $0, (%ebx, %edx, 1)
	movl %ebp, %esp
	popl %ebp
	ret
.globl expand
.type expand, @function
.equ ch, loc1
.equ i3, loc2
.equ j3, loc3
.equ s1, p1
.equ s2, p2
expand:
	pushl %ebp
	movl %esp, %ebp
	subl $16, %esp
	movl $0, i3(%ebp)	
	movl $0, j3(%ebp)
	jmp cndex
forex:
	movl i3(%ebp), %edx
	movl s1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	cmpb $45, %al
	jne elsex
	movl i3(%ebp), %edx
	addl $1, %edx
	movl s1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	xorl %ebx, %ebx
	movb ch(%ebp), %bl
	cmpb %bl, %al
	jnge elsex
	addl $1, i3(%ebp)
	jmp cndex1
elsex:
	movl j3(%ebp), %edx
	movl s2(%ebp), %ebx
	leal (%ebx, %edx, 1), %ecx
	xorl %eax, %eax
	movb ch(%ebp), %al
	movb %al, (%ecx)
	addl $1, j3(%ebp)
	jmp cndex
forex1:
	movl j3(%ebp), %edx
	movl s2(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	xorl %ecx, %ecx
	movb ch(%ebp), %cl
	movb %cl, (%eax)
	addl $1, ch(%ebp)
	addl $1, j3(%ebp)		
cndex1:
	movl i3(%ebp), %edx
	movl s1(%ebp), %ebx
	xorl %ecx, %ecx
	movb (%ebx, %edx, 1), %cl
	xorl %eax, %eax
	movb ch(%ebp), %al
	cmpb %cl, %al	
	jl forex1	
cndex:
	movl i3(%ebp), %edx
	movl s1(%ebp), %ebx
	xorl %eax, %eax
	movb (%ebx, %edx, 1), %al
	movb %al, ch(%ebp)
	addl $1, i3(%ebp)
	cmpb $0, %al
	jne forex
	movl j3(%ebp), %edx
	movl s2(%ebp), %ebx
	leal (%ebx, %edx, 1), %eax
	movb $0, (%eax)
	movl %ebp, %esp
	popl %ebp
	ret
copy:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	movl $0, -4(%ebp)
	jmp cndcpy
forcopy:
	movl -4(%ebp), %eax
	addl $1, %eax
	movl %eax, -4(%ebp)
cndcpy:
	movl 8(%ebp), %ecx
	movl -4(%ebp), %ebx
	leal (%ecx, %ebx, 1), %eax
	movl 12(%ebp), %ecx
	movl -4(%ebp), %ebx
	leal (%ecx, %ebx, 1), %edx
	movl (%edx), %ebx
	movl %ebx, (%eax)
	cmpl $0, (%eax)
	jne forcopy 
	movl %ebp, %esp
	popl %ebp
	movl $0, %eax
	ret
