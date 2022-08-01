	.data
	.text
	
	.globl _start
_start:
	movl $1, %eax
	movl $2, %ebx
	movl $3, %ecx
	movl $4, %edx
	call Add
	call Add
done:
	nop
Add:
	addl %ebx, %eax
	addl %ecx, %eax
	addl %edx, %eax
	ret
