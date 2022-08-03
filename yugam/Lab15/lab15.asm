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
        movl $0, %edx
        movl $0, %eax
        movl $0, %ebx
        decl %ecx
        call intiger
        call count
        call char
        call onebyone     
        jmp done  
    done:
        call exit

    intiger:
        inc %ecx
        movb (%ecx), %bl   
        cmpb $10, (%ecx)        
        je return
    mult:
        subb $48, %bl       
        mull multiply             
        addl %ebx, %eax
        jmp intiger
    return:    
        ret

    count: 
        movl %eax, %ecx
        movl $0, %ebx          
    increase2:
        movl $0, %edx        
        divl multiply                  
        inc %ebx               
        cmpl $0, %eax            
        jne increase2             
        ret
    
    char:
        movl %ecx, %eax
        movl $convertednum, %ecx 
        pushl %ebx     
    counter:
        cmpl $0, %ebx
        jne devide
        movl $0, %eax
        movl $convertednum, %eax
        je pushpop
    devide:
        movl $0, %edx       
        divl multiply
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
        je returnback
    returnback:
        popl %edx
        popl %ebx
        subl %ebx, %ecx
        ret

    onebyone:
        movl $convertedflip, %eax
    Looping:                
        cmpb $0, (%eax)
        jne Write
        jmp RETURN
    Up:
        inc %eax
        jmp Looping
    Write:
        movl %eax, %ecx
        call write
        movl %ecx, %eax
        jmp Up
    RETURN:
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
        movl  $text, %ecx   
        movl  $5, %edx         
        int   $0X80      
        ret               

    exit:
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
