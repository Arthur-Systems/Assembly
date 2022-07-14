.section .data: 
    .equ STDIN,0 
    .equ STDOUT,1 
    .equ READ,0 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

        string:
        .asciz "Hello World!\n"

       Write:
        movl $WRITE, %eax
        movl $STDOUT, %ebx
        movl $string, %ecx
     

     Exit:   # Exits gracefully
        movl $EXIT, %eax
        movl $SUCCESS, %ebx
        int $0X80


.section .text
    .global _start
    _start:
        movl $WRITE, %eax
        movl $STDOUT, %ebx
        movl $string, %ecx
        movl $0, %edx
    loop1:
        cmp $0, (%ecx)
        inc %edx
        jne loop2
        jmp done
    loop2: 
        inc %ecx

        jmp loop1

        
    done:
        int $0X80
        call Exit
     
        



        


    

    
    