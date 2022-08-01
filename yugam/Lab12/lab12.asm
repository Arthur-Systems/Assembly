# Register Use List:
# eax: eax is only used for multication and storing the result.
# ebx: ebx (bl) is used for storing each byte of ecx.
# ecx: ecx is used to store the user inputted ascii number.
# edx: edx is only used for the syscalls.
	
	.data # data section
	.equ STDIN, 0
	.equ STDOUT, 1
	.equ READ, 3
	.equ WRITE, 4
	.equ EXIT, 1
	.equ SUCCESS, 0
	
buffer:
	.ascii " "
	.byte 10
	
ten:
	.long 10
	
	.text
	.globl _start
_start:
	movl $READ, %eax
	movl $STDIN, %ebx
	movl $buffer, %ecx
	movl $5, %edx
	int $0X80
clear:
	movl $0, %eax
	movl $0, %ebx
	decl %ecx
converttoint:
	inc %ecx
	movb (%ecx), %bl
	cmpb $10, (%ecx)
	je done
	subb $48, %bl
	mull ten
	addl %ebx, %eaxs
	jmp converttoint
done:
	nop # eax should be looked into here
	movl $EXIT, %eax
	movl $SUCCESS, %ebx
	int $0x80
