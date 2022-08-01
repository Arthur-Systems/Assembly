	# This program adds the four numbers in the "array" x
# This program is from Section 3.4, pp. 64 - 65 in "Below C Level:
	# An Introduction to Computer Systems", by Norm Matloff
	# Comments were added by Jim Hoffman
	
	
	.data # The data section
	
x:
	.long 1
	.long 5
	.long 2
	.long 18
	
sum:
	.long 0
	
	.text # The text section
	
	.globl _main # Make the symbol main global
	
_main:
	movl $4, eax
	movl $0, %ebx
	movl $x, %ecx
top:
	addl (%ecx), %ebx
	addl $4, %ecx
	decl %eax
	jnz top
done:
	movl %ebx, sum
