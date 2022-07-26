# a register use list is listed for each subrutine below.

.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    prompt_start:
        .ascii "Input(Int): "

    prompt_count:
        .equ START, . - prompt_start
        
    prompt_end:
        .ascii "Converted:"

    prompt_count_end:
        .equ END, . - prompt_end

    buffer:
        .ascii "  "
        .byte 10

    number:
        .long 0

    endnum:
        .long 0

    ten:
        .byte 10
    POT:
        .byte 1

    write: # write ascii text
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $WRITE,  %eax    # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx    # %ebx: Moves STDOUT 
        # movl   $prompt_start,%ecx    # %ecx: moves the length into ecx
        # movl  $START, %edx      # %edx: moves the text being written into edx
        int   $0X80             # syscall
        ret                     # return 

    read: # Read user input
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $READ,  %eax      # %eax: Moves the read syscall into eax
        movl  $STDIN, %ebx      # %ebx: Moves STDIN into ebx
        movl  $buffer, %ecx     # %ecx: Output is put into buffer  
        movl  $5, %edx          # %edx: The Maxium characters it will accept 5
        int   $0X80             # syscall
        ret                     # return 

    userinput:
    # Registers being replaced: %eax, %edx
    # register use list:
    # %eax: stores the user input
    # %ebx: not used
    # %ecx:  not used
    # %edx: used as counter so cleared 
        call read               # call read function
        movl %ecx, %eax         # copy the user input into to the eax register 
        movl $0, %edx           # reset edx to 0
        call countchar          # call countchar function
        ret

    converttoint:
    # Registers being replaced: %eax, %ebx, %ecx, %edx
    # register use list:
    # %eax: eax is first used to copy the user input to ecx so it can be freed up to use for multiplication
    # %ebx: ebx is used as the counter for the program 
    # %ecx: ecx is used to store the user input and is minnipulated
    # %edx: ed is cleared to be used for the multiplication
        movl %eax, %ecx         # copy the user input BACK into to the ecx register
        movl $0, %eax           # reset eax to 0
        movl %edx, %ebx         # copy edx to ebx
        movl $0, %edx           # reset edx to 0
        jmp math1               # jump to math1
    math1: # part of the convertion function
        subb $48, (%ecx)        # subtract 48 bytes from the value in ecx 
        addb (%ecx), %al        # add the current value in ecx to al 
        inc %ecx                # increase eax
        decl %ebx               # decrease ebx 
        cmpl $0, %ebx           # compare ebx to 0
        jne multiply            # if not equal, jump to multiply
        je return               # if euqal, jump to return
    multiply:   # part of the convertion function
        mulb ten                # multiply by 10 
        jmp math1               # jump to math
    return:     # part of the convertion function
        movl %eax, endnum
        ret
    
    converttochar:
    # Registers being replaced: %eax, %ebx, %ecx, %edx
    # register use list:
    # %eax: 
    # %ebx: 
    # %ecx: 
    movl %ecx, %eax
    movl %edx, %ebx
    counter:
    cmpl $0, %edx
    jne convert
    je return2
    convert:
    divl ten
    addb $48, (%edx)
    movl %edx, buffer
    decl %ebx
    jmp counter
    multiply2:
    mull ten
    return2:
    ret

    countint:
    movl %eax, %ecx  # copy the user input into to the ecx register
    movl $0, %edx     # reset eax to 0
    increase2:
    divl ten        # divide by 10
    inc %edx        # increase edx
    cmpl $0, %eax   # compare edx to 0
    jne increase2    # if not equal, jump to increase
    ret



    countchar: # counts the number of characters in any given string. 
    # Registers being replaced: %ecx, %edx
    # register use list:
    # %eax: eax is not used
    # %ebx: ebx is not used
    # %ecx: ecx is used to store the string being counted and is compared to 10 to count to the end
    # %edx: edx is the counter for the program and is increased by 1 each time the loop is run
        cmpb $10, (%ecx)        # compare the value at the current pointer in ecx to 10
        jne increase            # if its not equal, jump to increase
        ret                     # if equal, return
    increase:                   
        inc %ecx                # incrase the pointer in ecx
        inc %edx                # increase edx %edx: Will be the counter of the program so the program knows how long the input is and knows when to terminate
        jmp countchar           # jump to countchar


    exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
        
        
.text
    .globl _start
    _start:
        movl $prompt_start,%ecx
        movl $START, %edx
        call write
        call userinput
        call converttoint
        movl $prompt_end,%ecx
        movl $END, %edx
        call write
        movl $endnum, %ecx
        movl (%ecx), %eax
        call countchar
        call converttochar
        movl $buffer, %ecx
        movl $END, %edx
        call write
done:
    call exit



