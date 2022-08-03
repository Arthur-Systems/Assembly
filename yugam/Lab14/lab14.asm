.data           
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    text:
        .ascii "  "
        .byte 10

    number:
        .long 0

    multiply:
        .long 10

.text          
    .globl _start
    _start:        
        call read               
        call clear
        call intiger   
    done:
        call exit   

    clear:
        movl $0, %edx          
        movl $0, %eax          
        movl $0, %ebx
        decl %ecx 

    intiger:
        inc %ecx
        movb (%ecx), %bl   
        cmpb $10, (%ecx)        
        je return
    convert:
        subb $48, %bl       
        mull multiply             
        addl %ebx, %eax
        jmp intiger
    return:
        movl %eax, number         
        ret

    exit:
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
    read: 
        movl  $READ,  %eax     
        movl  $STDIN, %ebx    
        movl  $text, %ecx     
        movl  $5, %edx          
        int   $0X80            
        ret         
