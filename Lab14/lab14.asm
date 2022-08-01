	# a register use list is listed for each subrutine below.
	
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
	
number:
	.long 0
	
ten:
	.byte 10
	
prompt_start:
.ascii "Input(Int): "
	
prompt_count:
	.equ START, . - prompt_start
	
	
	.text # code section
	.globl _start
_start:
	movl $prompt_start, %ecx
	movl $START, %edx
	call write # write prompt to stdout
	call userinput # read the input and sets up other things
	call converttoint # convert the input string to integer
	movl endnum, %eax
done:
	call exit
	
	
write: # write ascii text
# Registers being replaced: %eax, %ebx, %ecx, %edx
movl $WRITE, %eax # %eax: Moves the write syscall into eax
movl $STDOUT, %ebx # %ebx: Moves STDOUT
# %ecx %edx: will be passed in exterinally
	int $0X80 # syscall
	ret # return
	
read: # Read user input
# Registers being replaced: %eax, %ebx, %ecx, %edx
movl $READ, %eax # %eax: Moves the read syscall into eax
movl $STDIN, %ebx # %ebx: Moves STDIN into ebx
movl $buffer, %ecx # %ecx: Output is put into buffer
movl $5, %edx # %edx: The Maxium characters it will accept 5
	int $0X80 # syscall
	ret # return
	
userinput:
# Registers being replaced: %eax, %edx
# register use list:
# %eax: stores the user input
# %ebx: not used
# %ecx: not used
# %edx: used as counter so cleared
	call read # call read function
	movl $0, %edx # reset edx to 0
	movl $0, %eax # reset eax to 0
	movl $0, %ebx # reset eax to 0
	decl %ecx
	ret
	
converttoint: # converts ascii to int
# Registers being replaced: %eax, %edx
# register use list:
# eax: eax is only used for multication and storing the result.
# ebx: ebx (bl) is used for storing each byte of ecx.
# ecx: ecx is used to store the user inputted ascii number.
# edx: edx is only used for the syscalls.
	inc %ecx
	movb (%ecx), %bl
	cmpb $10, (%ecx) # compare the byte at the current location of the pointer at ecx to 10
	je return
	subb $48, %bl # subtract 48 bytes from the byte in ecx to get the int value of the ascii number
	mull ten # multiply the int value of the ascii number by 10
	addl %ebx, %eax
	jmp converttoint
return:
	movl %eax, endnum # move eax to endnum
	ret
	
exit: # exit the program
	movl $EXIT, %eax
	movl $SUCCESS, %ebx
	int $0x80
