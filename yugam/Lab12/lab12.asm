	.data # data section
	.equ STDIN, 0
	.equ STDOUT, 1
	.equ READ, 3
	.equ WRITE, 4
	.equ EXIT, 1
	.equ SUCCESS, 0
	
buffer: # taken from example
	.ascii " "
	.byte 10
	
multiply:
	.long 10

	.text
	.globl _start
_start:
	movl $READ, %eax
	movl $STDIN, %ebx
	movl $buffer, %ecx
	movl $5, %edx
	int $0X80
	movl $0, %eax
	movl $0, %ebx
	decl %ecx
CTI:
	inc %ecx
	movb (%ecx), %bl
	cmpb $10, %bl
	je done
	subb $48, %bl
	mull multiply
	addl %ebx, %eax
	jmp CTI
done:
	nop
	movl $EXIT, %eax
	movl $SUCCESS, %ebx
	int $0x80
