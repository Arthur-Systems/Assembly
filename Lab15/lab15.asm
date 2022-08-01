	# @author Arthur Wei
	# @version Lab 15
	# @date 2022 - 07 - 28
	
	# a register use list is listed for each subrutine below.
	
	.data # data section
	.equ STDIN, 0
	.equ STDOUT, 1
	.equ READ, 3
	.equ WRITE, 4
	.equ EXIT, 1
	.equ SUCCESS, 0
	
prompt_start:
.ascii "Input(Int): "
	
prompt_count:
	.equ START, . - prompt_start
	
prompt_end:
.ascii "Converted:"
	
prompt_count_end:
	.equ END, . - prompt_end
	
EOL:
	.ascii "\n"
	
buffer:
	.ascii " "
	.byte 10
	
convertednum:
	.ascii " "
	.byte 0
	
convertedflip:
	.ascii " "
	.byte 10
	
number:
	.long 0
	
endnum:
	.long 0
POT:
	.long 10
	
	.text
	.globl _start
_start:
	movl $prompt_start, %ecx
	movl $START, %edx
	call write
	call userinput
	call converttoint
	call countint
	call converttochar
	movl $prompt_end, %ecx
	movl $END, %edx
	call write
	call loopwrite # print letter by letter
	jmp done # jump to done
done:
	call EOP # prints a new line at the end of the program
	call exit
	
# Docment Run:
# arthur@DESKTOP - KJAD1M1:~ / Assembly / Lab15$ . / a.out
# Input(Int): 123
# Converted:123
# arthur@DESKTOP - KJAD1M1:~ / Assembly / Lab15$ . / a.out
# Input(Int): 647
# Converted:647
# arthur@DESKTOP - KJAD1M1:~ / Assembly / Lab15$ . / a.out
# Input(Int): 56
# Converted:56
	
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
	
exit: # exit the program
	movl $EXIT, %eax
	movl $SUCCESS, %ebx
	int $0x80
	
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
	mull POT # multiply the int value of the ascii number by 10
	addl %ebx, %eax
	jmp converttoint
return:
	movl %eax, endnum # move eax to endnum
	ret
	
countint: # count the number of numbers in the user input
	movl $0, %ebx # reset eax to 0
increase2:
	movl $0, %edx # reset eax to 0
	divl POT # divide by 10
	inc %ebx # increase edx
	cmpl $0, %eax # compare edx to 0
	jne increase2 # if not equal, jump to increase
	ret
	
converttochar:
# Registers being replaced: %eax, %ebx, %ecx, %edx
# register use list:
# %eax: is used to store the devided number so its cleared and not used
# %ebx: is used as the counter. If ebx is 0, then the loop is stopped
# %ecx: ecx is used to store the number to be devided and is minnipulated
# %edx: edx or (dl) is used to store the remainder witch will be used to get the ascii value
	
	movl endnum, %eax
	movl $convertednum, %ecx
	pushl %ebx # push the counter (ebx) onto the stack so we can save it for later
counter: # comareative statement to see if the program has run though the loop enough time
	cmpl $0, %ebx
	jne convert
	movl $0, %eax
	movl $convertednum, %eax
	je pushpop
convert: # takes the number in ecx and take it digit by digit then adding 48 bytes to it to get the ascii
	movl $0, %edx
	divl POT
	addb $48, %dl
	movb %dl, (%ecx)
	inc %ecx
	decl %ebx
	jmp counter
pushpop: # push and pop of ebx
	popl %ebx # pop the counter (ebx) off the stack
	pushl %ebx # push the counter (ebx) onto the stack so we can save it for later
flip: # flip all the bits in the number and store it in eax
	movl $convertedflip, %ecx
	movb $0, %dl
	decl %ebx
	movl %ebx, %edx
	jmp fliploop1
fliploop:
	popl %edx
	subl %edx, %eax
	movl %edx, %ebx
	decl %ebx
	movl %ebx, %edx
fliploop1:
	cmpl $0, %ebx
	jle flipcont
	inc %eax
	decl %ebx
	jmp fliploop1
flipcont:
	pushl %edx
	movl $0, %edx
	movb (%eax), %dl
	movb %dl, (%ecx)
	inc %ecx
	movb convertednum, %bl
	cmpb %bl, %dl
	jne fliploop
	je return2
return2: # resets the pointer to the beginning and returns the converted number
	popl %edx
	popl %ebx
	subl %ebx, %ecx
	ret
	
loopwrite: # looping statement to print the converted number letter by letter
	
# Registers being replaced: %eax, %ebx, %ecx, %edx
# register use list:
# %eax: Stores the final number to be printed
# %ebx: Not used
# %ecx: ecx is used for the system call to print the number
# %edx: used for syscall
	movl $convertedflip, %eax
Looping:
	cmpb $0, (%eax) # compare the current byte of the string with 0
	jne Write # if not equal, jump to the Write function
	jmp Return3 # if equal, jump to done
Up:
	inc %eax # increase the pointer to the string
	jmp Looping
Write:
	movl %eax, %ecx # copy the pointer to ecx
	movl $1, %edx
	call write
	movl %ecx, %eax # Restore pointer
	jmp Up
Return3:
	ret
	
EOP: # end of program prints a new line
	movl $1, %edx
	movl $EOL, %ecx
	call write
	ret
