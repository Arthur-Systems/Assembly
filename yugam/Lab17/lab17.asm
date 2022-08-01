# @author Arthur Wei  
# @version Lab 17
# @date 2022-08-01

# a register use list is listed for each subrutine below.

.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    prompt_end:
        .ascii "The substring was found at position: "

    prompt_count_end:
        .equ END, . - prompt_end

    prompt_NOTFOUND:
        .ascii "The substring was NOT found!"

    prompt_count_NOTFOUND:
        .equ NOTFOUND, . - prompt_NOTFOUND

    EOL:
        .ascii "\n"

    buffer:
        .ascii " "
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
    POT:
        .long 10

    main_string:
        .ascii "acentuate"
        .byte 10

    substring:
        .ascii "ntuate"
        .byte 10
.text
    .globl _start
    _start:
        subl $8, %esp 
        movl $main_string, %eax
        movl %eax, (%esp)
        movl $substring, %eax   
        movl %eax, 4(%esp)         
        movl $0, %eax
        call find_string
        movl (%esp), %eax            
        cmpl $-1, %eax
        je NEGFOUND 
        movl $prompt_end,%ecx   
        movl $END, %edx
        call write
        movl (%esp), %eax
        call countint
        call converttochar
        call loopwrite
        jmp done 
    done:
        call EOP 
        call exit

    write:
        movl  $WRITE,  %eax     
        movl  $STDOUT, %ebx     
        int   $0X80             
        ret                  

    find_string:
        pushl %ebp
        movl %esp, %ebp
        movl 8(%ebp), %eax         
        movl 12(%ebp), %ecx        
        movb (%ecx), %dl
        movl $1, %ecx          
    compare:
        cmpb %dl, (%eax)
        je checknext
        inc %eax
        inc %ecx           
        cmpb $10, (%eax)
        je returnneg
        jmp compare 
    checknext:
        inc %eax
        cmpb %dl, (%eax)
        jne pushecx
        inc %ecx
        jmp checknext
    pushecx:
        pushl %ecx
        movl 12(%ebp), %ecx
    found:
        inc %ecx
        movb (%ecx), %dl
        cmpb $10, %dl
        je return
        jne foundloop
    foundloop:
        cmpb %dl, (%eax)
        jne returnneg1
        je inceax
    inceax:
        inc %eax
        jmp found
    
    return:
        popl %ecx
        movl %ecx, 8(%ebp)
        popl %ebp
        ret
    returnneg:
        movl $-1, 8(%ebp)
        popl %ebp
        ret

    returnneg1:
        popl %ecx
        movl $-1, 8(%ebp)
        popl %ebp
        ret

    countint: 
        movl %eax, %ecx
        movl $0, %ebx               
    increase2:
        movl $0, %edx               
        divl POT                    
        inc %ebx                   
        cmpl $0, %eax             
        jne increase2               
        ret

    converttochar:
        movl %ecx, %eax
        movl $0, %ecx 
        movl $buffer, %ecx  
    counter:
        cmpl $0, %ebx
        jne convert
        movl $0, %eax
        movl $convertednum, %eax
        je flip
    convert:
        movl $0, %edx       
        divl POT
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


    loopwrite: 
        movl $convertednum, %eax
    Looping:                
        cmpb $10, (%eax)   
        jne Write           
        jmp Return3        
    Up:
        inc %eax          
        jmp Looping
    Write:
        movl %eax, %ecx   
        movl $1, %edx
        call write
        movl %ecx, %eax    
        jmp Up
    Return3:
        ret

    EOP: 
        movl $1, %edx
        movl $EOL, %ecx 
        call write
        ret

    NEGFOUND:
        movl $NOTFOUND, %edx
        movl $prompt_NOTFOUND, %ecx 
        call write
        call EOP
        call exit

    exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80

