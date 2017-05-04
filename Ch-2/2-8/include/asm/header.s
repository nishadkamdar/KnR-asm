# main's argument offsets with respect to ebp
.equ	argc, 4
.equ	argv, 8

# Actual argument's offsetes with respect ot esp
.equ 	arg1, 0
.equ 	arg2, 4
.equ 	arg3, 8
.equ 	arg4, 12
.equ 	arg5, 16
.equ 	arg6, 20
.equ 	arg7, 24
.equ 	arg8, 28
.equ 	arg9, 32
.equ 	arg10, 36

# Formal parameters offsets with respect to ebp
.equ 	p1, 8
.equ 	p2, 12
.equ 	p3, 16
.equ 	p4, 20
.equ 	p5, 24
.equ 	p6, 28
.equ 	p7, 32
.equ 	p8, 36
.equ 	p9, 40
.equ 	p10, 44

# Local variable offsets with respect to ebp
.equ 	loc1, -4
.equ	loc2, -8
.equ	loc3, -12
.equ	loc4, -16
.equ	loc5, -20
.equ	loc6, -24
.equ	loc7, -28
.equ	loc8, -32
.equ	loc9, -36
.equ	loc10, -40 
