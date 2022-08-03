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
        .byte 10

    number:
        .long 30

    endnum:
        .long 0

    multiply:
        .long 10

.text
    .globl _start
    _start:
        subl $4, %esp 
        movl number, %ecx
        movl %ecx, (%esp) 
        movl $0, %ecx
        call square
        movl (%esp), %eax
        call count
        call char
        movl $convertednum, %eax
        call onebyone      
        jmp done         
    done:      
        call exit

    square: 
        pushl %ebp
        movl %esp, %ebp
        movl 8(%ebp), %ecx
        movl %ecx, %eax
        mull %ecx    
        movl %eax, 8(%ebp)
        popl %ebp
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
        movl $0, %ecx 
        movl $text, %ecx  
    counter:
        cmpl $0, %ebx
        jne convert
        movl $0, %eax
        movl $convertednum, %eax
        je flip
    convert:  
        movl $0, %edx       
        divl multiply
        addb $48, %dl
        movb %dl, (%ecx)
        inc %ecx
        decl %ebx
        jmp counter
    flip:         
        movb $0, %dl
        decl %ecx
        movb (%ecx), %dl
        movb %dl, (%eax)
        inc %eax
        inc %ebx
        cmpl $3, %ebx
        jne flip
        je return2
    return2:    
        subl %ebx, %eax
        ret

    onebyone:
        movl $convertednum, %eax
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
