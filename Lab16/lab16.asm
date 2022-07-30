.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

write: # write ascii text
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $WRITE,  %eax    # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx    # %ebx: Moves STDOUT 
        # movl   $prompt_start,%ecx    # %ecx: moves the length into ecx
        # movl  $START, %edx      # %edx: moves the text being written into edx
        int   $0X80             # syscall
        ret                     # return 

exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
buffer:
    .ascii " "
    .byte 20

convertednum:
    .ascii " "
POT:
    .long 10

countint: # count the number of numbers in the user input
    movl %eax, %ecx             # copy the user input into to the ecx register
    movl $0, %ebx               # reset eax to 0
    increase2:
    movl $0, %edx               # reset eax to 0
    divl POT                    # divide by 10
    inc %ebx                    # increase edx
    cmpl $0, %eax               # compare edx to 0
    jne increase2               # if not equal, jump to increase
    ret

converttochar:
    # Registers being replaced: %eax, %ebx, %ecx, %edx
    # register use list:
    # %eax: is used to store the devided number so its cleared and not used
    # %ebx: is used as the counter. If ebx is 0, then the loop is stopped
    # %ecx: ecx is used to store the number to be devided and is minnipulated
    # %edx: edx or (dl) is used to store the remainder witch will be used to get the ascii value

    movl %ecx, %eax
    movl $0, %ecx 
    movl $buffer, %ecx  
    counter:            # comareative statement to see if the program has run though the loop enough time 
    cmpl $0, %ebx
    jne convert
    movl $0, %eax
    movl $convertednum, %eax
    je flip
    convert:            # takes the number in ecx and take it digit by digit then adding 48 bytes to it to get the ascii 
    movl $0, %edx       
    divl POT
    addb $48, %dl
    movb %dl, (%ecx)
    inc %ecx
    decl %ebx
    jmp counter
    flip:           # due to the fact i used the REMAINDER of the division to get the ascii, i had to flip the order of the digits
    movb $0, %dl
    decl %ecx
    movb (%ecx), %dl
    movb %dl, (%eax)
    inc %eax
    inc %ebx
    cmpl $3, %ebx
    jne flip
    je return2
    return2:    # resets the pointer to the beginning of the buffer and returns the converted number
    subl %ebx, %eax
    ret





square:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %ecx
    movl %ecx, %eax
    mull %ecx       # number * number
    movl %eax, 8(%ebp)
    popl %ebp
    ret
    
number:
    .long 10

.text
    .globl _start
    _start:
    subl $4, %esp # reserve space for the stack frame
    movl number, %eax
    movl %eax, (%esp) # store the number of arguments in the stack frame
    movl $0, %eax
    call square
    movl (%esp), %eax
    call countint
    call converttochar
    movl $convertednum, %eax

    Looping:                # looping statement to print the converted number letter by letter
        cmpb $0, (%eax)    # compare the current byte of the string with 0
        jne Write          # if not equal, jump to the Write function
        jmp done           # if equal, jump to done
    Up:
        inc %eax           # increase the pointer to the string
        jmp Looping
    Write:
        movl %eax, %ecx    # copy the pointer to ecx
        movl $1, %edx
        call write
        movl %ecx, %eax    # Restore pointer
        jmp Up

done:
    call exit

EOP:
    movl $EOL, %edx
    movl $1, %ecx
    call write
    ret