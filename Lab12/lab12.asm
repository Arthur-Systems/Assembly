.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    prompt:
        .ascii "Type Int: "
        .byte 10

    prompt_end:
        .ascii "Converted:"
        .byte 10
   
    number:
        .ascii "  "
        .byte 10

    buffer:
        .ascii "  "
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
        movl  $LENGTH, %edx
        int   $0X80
        ret

    converttoint:

# counts the number of characters in any given string. 
    countchar: 
        cmpb $10, (%eax)
        jne increase
        ret
        increase:
            inc %eax
            inc %edx
            jmp countchar

    exit:
        movl $EXIT,%eax
        int $0x80
        
        
.text
    .globl _start
    _start:

    movl $prompt,%ecx
    call countchar

    call write

    call read

    movl $buffer,%ecx
   
    call write

   # mov (%ecx), $number

   

done:
    call exit



