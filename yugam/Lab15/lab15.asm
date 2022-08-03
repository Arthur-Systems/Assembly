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
    multiply:
        .long 10
        
.text
    .globl _start
    _start:
        call read
        call clear
        call intiger
        call count
        call converttochar
        call onebyone     
        jmp done  
    done:
        call exit



    clear:
        movl $0, %edx
        movl $0, %eax
        movl $0, %ebx
        decl %ecx
        ret

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

    count: 
        movl $0, %ebx          
    increase2:
        movl $0, %edx        
        divl POT                  
        inc %ebx               
        cmpl $0, %eax            
        jne increase2             
        ret
    
    converttochar:
        movl endnum, %eax
        movl $convertednum, %ecx 
        pushl %ebx     
    counter:
        cmpl $0, %ebx
        jne convert
        movl $0, %eax
        movl $convertednum, %eax
        je pushpop
    convert:
        movl $0, %edx       
        divl POT
        addb $48, %dl
        movb %dl, (%ecx)
        inc %ecx
        decl %ebx
        jmp counter
    pushpop:
        popl %ebx
        pushl %ebx
    flip:
        movl $convertedflip, %ecx   
        movb $0, %dl
        decl %ebx
        movl %ebx, %edx
        jmp fliploop1
    fliploop:
        popl %edx
        subl %edx, %eax
        movl %edx, %ebx
        decl %ebx
        movl %ebx, %edx
    fliploop1:
        cmpl $0, %ebx
        jle flipcont
        inc %eax
        decl %ebx
        jmp fliploop1
    flipcont:
        pushl %edx
        movl $0, %edx
        movb (%eax), %dl
        movb %dl, (%ecx)
        inc %ecx
        movb convertednum, %bl
        cmpb %bl, %dl
        jne fliploop
        je return2
    return2:
        popl %edx
        popl %ebx
        subl %ebx, %ecx
        ret

    onebyone:
        movl $convertedflip, %eax
    Looping:                
        cmpb $0, (%eax)
        jne Write
        jmp Return3
    Up:
        inc %eax
        jmp Looping
    Write:
        movl %eax, %ecx
        call write
        movl %ecx, %eax
        jmp Up
    Return3:
        ret

    write: 
        movl  $WRITE,  %eax   
        movl  $STDOUT, %ebx     
        movl $1, %edx
        int   $0X80            
        ret                     

    read: 
        movl  $READ,  %eax   
        movl  $STDIN, %ebx  
        movl  $buffer, %ecx   
        movl  $5, %edx         
        int   $0X80      
        ret               

    exit:
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80