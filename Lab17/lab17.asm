.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    prompt_end:
        .ascii "The substring was found at position: "

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


main_string:
    .ascii "accentuate"
    .byte 10
substring:
    .ascii "cent"
    .byte 10



.text
    .globl _start
    _start:
        subl $8, %esp # reserve space for the stack frame
        movl $main_string, %eax
        movl %eax, (%esp) # store the number of arguments in the stack frame
        movl $substring, %eax
        movl %eax, 4(%esp) 
        movl $0, %eax
        call find_string

        movl $prompt_end,%ecx   
        movl $END, %edx
        call write
        movl (%esp), %eax
        call countint
        call converttochar
        movl $convertednum, %eax
        call loopwrite     # print letter by letter
        jmp done           # jump to done
    done:
        call EOP           # prints a new line at the end of the program
        call exit

    write: # write ascii text
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $WRITE,  %eax     # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx     # %ebx: Moves STDOUT 
        # %ecx %edx: will be passed in exterinally
        int   $0X80             # syscall
        ret                     # return 

    find_string:
        pushl %ebp
        movl %esp, %ebp
        movl 8(%ebp), %eax      
        movl 12(%ebp), %ecx
        movb (%ecx), %dl
        movl $0, %ecx

    compare:
        cmpb %dl, (%eax)
        je pushecx
        inc %eax
        inc %ecx            # position in main_string
        cmpb $10, (%eax)
        je returnneg1
        jmp compare
    pushecx:
        pushl %ecx
        movl 12(%ebp), %ecx
    found:
        inc %ecx
        movb (%ecx), %dl
        cmpb $10, %dl
        je return
    foundloop:
        inc %eax
        cmpb %dl, (%eax)
        jne return
        je found

    return:
        popl %ecx
        movl %ecx, 8(%ebp)
        popl %ebp
        ret
    
    returnneg1:
        movl $-1, 8(%ebp)
        popl %ebp
        ret

    countint: # count the number of numbers in the user input
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


    loopwrite:     # looping statement to print the converted number letter by letter
    # Registers being replaced: %eax, %ebx, %ecx, %edx
    # register use list:
    # %eax: Stores the final number to be printed
    # %ebx: Not used
    # %ecx: ecx is used for the system call to print the number
    # %edx: used for syscall
        movl $convertednum, %eax
    Looping:                
        cmpb $0, (%eax)    # compare the current byte of the string with 0
        jne Write          # if not equal, jump to the Write function
        jmp Return3           # if equal, jump to done
    Up:
        inc %eax           # increase the pointer to the string
        jmp Looping
    Write:
        movl %eax, %ecx    # copy the pointer to ecx
        movl $1, %edx
        call write
        movl %ecx, %eax    # Restore pointer
        jmp Up
    Return3:
        ret

    EOP: # end of program prints a new line
        movl $1, %edx
        movl $EOL, %ecx 
        call write
        ret

    exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80

