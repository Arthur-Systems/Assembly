
.data
    .equ STDIN,0 
    .equ STDOUT,1 
    .equ READ,0 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    string:
        .ascii "hello, wor1d\n"

    string_end:
    .equ len, string_end - string
    
    Write:
        movl $WRITE, %eax
        movl $STDOUT, %ebx
        movl $string, %ecx
        movl $len, %edx
        int $0X80
    
    Exit:   # Exits gracefully
        movl $EXIT, %eax
        movl $SUCCESS, %ebx
        int $0X80
.text 
    .globl _start
    _start:
       
        call Write
        call Exit 


