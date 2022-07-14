.section .data
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,0 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

string:
    .asciz "hello, wor1d\n"
    .asciz "hello, wor1d\n"

Write:
    movl %ecx, %ecx  # Hello world string
    movl $WRITE, %eax   # System call number 4
    movl $STDOUT, %ebx  # stdout has descriptor
    movl %edx, %edx     # String length
    int $0X80
    ret


.section .text
    .globl _start
_start:
        movl $string, %eax
    loop1:

        movl 13(%eax), %esi
        mov (%esi), %dl
        movl $0, %edi
        mov (%edi), %cl
        cmp %cl, %dl
        # cmpsd
        jne shift
        jmp done
        call Write
        jmp done
    loop2:
        inc %edx
        inc %eax
        jmp loop1
    shift:
        shll $7, %eax
        jmp loop2
    done:
        movl $EXIT, %eax
        movl $SUCCESS, %ebx
        int $0X80

     
        



        


    

    
    