.section .data

    .equ    STDIN,0 
    .equ    STDOUT,1 
    .equ    READ,0 
    .equ    WRITE,4
    .equ    EXIT,1
    .equ    SUCCESS,0

string:
    .ascii "hello, wor1d\n"

string_end:
    .equ len, string_end - string

.section .text
    .globl _start

_start:
    # Prints the string "hello world\n" on the screen
    movl $WRITE, %eax   # System call number 4
    movl $STDOUT, %ebx  # stdout has descriptor
    movl $string, %ecx  # Hello world string
    movl $len, %edx     # String length
    int  $0X80          # System call code

    # Exits gracefully
    movl $EXIT, %eax    # System call number O
    movl $SUCCESS, %ebx # Argument is 0
    int  $0X80          # System call code

