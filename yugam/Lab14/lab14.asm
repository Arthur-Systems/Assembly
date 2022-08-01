# a register use list is listed for each subrutine below.

.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    buffer:
        .ascii "  " 
        .byte 10

    number:
        .long 0

    ten:
        .byte 10

.text          
    .globl _start
    _start:        
        call read               
        call clear
        decl %ecx     
        call converttoint   
        movl endnum, %eax
    done:
        call exit        
    clear:
        movl $0, %edx          
        movl $0, %eax          
        movl $0, %ebx  

    converttoint:
        inc %ecx
        movb (%ecx), %bl   
        cmpb $10, (%ecx)        
        je return
    convert:
        subb $48, %bl           
        mull ten             
        addl %ebx, %eax
        jmp converttoint
        
    return:
        movl %eax, endnum         
        ret
    exit:
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
    read: 
        movl  $READ,  %eax     
        movl  $STDIN, %ebx    
        movl  $buffer, %ecx     
        movl  $5, %edx          
        int   $0X80            
        ret         
