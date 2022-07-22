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

  

    read:
        movl  $READ,  %eax
        movl  $STDIN, %ebx
        movl  $buffer, %ecx
        movl  $5, %edx
        int   $0X80
        ret

    write:
        movl  $WRITE,  %eax
        movl  $STDOUT, %ebx
        # movl  $number, %ecx
        # movl  $LENGTH, %edx
        int   $0X80
        ret

    userinput:
        call read
        movl $buffer, %eax      # copy buffer to the eax register    
        movl $0, %edx           # reset edx to 0
        call countchar 
        ret

    converttoint:
        movl %eax, %ecx         # copy eax to ecx
        movl $0, %eax           # reset eax to 0 
        movl %edx, %ebx         # copy edx to ebx
        jmp math1

    math1: 
        subb $48, (%ecx)    # subtract 48 from the character
        addb (%ecx), %al    #
        inc %ecx
            # movl %ebx, %edx
        decl %ebx
            # movl %edx, %ebx    # copy edx to number
            # movl $1, %eax
        cmpl $0, %ebx
        jne multiply
        je return
    multiply:
        mulb ten            #
        jmp math1

       # up: 
       #     movl $1, %eax
       #     jmp math2
       # math2:x
       #     cmpl $0, %ebx        # check if edx is 0
       #     jne multiply           
       #     je math1
       # multiply:
       #     movl $10, %edx
       #     mull %edx
       #     decl %ebx
       #     jmp math2
        return:
            movl %eax, endnum
            ret

    countchar:  # counts the number of characters in any given string. 
        cmpb $10, (%ecx)
        jne increase
        ret
        increase:
            inc %ecx
            inc %edx
            jmp countchar

    exit:
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
        
        
.text
    .globl _start
    _start:
        movl $prompt_start,%ecx
        movl  $START, %edx
        call write
        call userinput
        call converttoint
        movl $prompt_end,%ecx
        movl $END, %edx
        call write
        movl $endnum, %eax
        movl (%eax),%ecx
        movl  $5, %edx
        call write
done:
    call exit



