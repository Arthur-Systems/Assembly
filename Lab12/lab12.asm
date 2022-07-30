# Register Use List:
# eax: Besides for the input and write syscalls eax is mostly used storage space for input then it is used to store the final output
# ebx: ebx is used as the counter for the program. 
# ecx: ecx is used to store the and mininpulate ascii data.  
# edx:  edx is ALSO used as the counter for the program but gets cleared so it needs ebx to step in. 

.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    prompt_start:
        .ascii "Input(Int): "

    prompt_count:
        .equ START, . - prompt_start

    buffer:
        .ascii "  "
        .byte 10

    number:
        .long 0

    endnum:
        .long 0

    ten:
        .long 10                

.text
    .globl _start
    _start:
    write: # write ascii text
        movl  $WRITE,  %eax    # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx    # %ebx: Moves STDOUT 
        movl $prompt_start,%ecx    # %ecx: moves the length into ecx
        movl  $START, %edx      # %edx: moves the text being written into edx
        int   $0X80             # syscall

    read: # Read user input
        movl  $READ,  %eax      # %eax: Moves the read syscall into eax
        movl  $STDIN, %ebx      # %ebx: Moves STDIN into ebx
        movl  $buffer, %ecx     # %ecx: Output is put into buffer   %ecx:contains the input of the user 
        movl  $5, %edx          # %edx: The Maxium characters it will accept
        int   $0X80             # syscall
        movl $0, %eax           # reset eax to 0
        movl $0, %ebx           # reset eax to 0
        decl %ecx
    
    converttoint:               # converts ascii to int
        inc %ecx
        movb (%ecx), %bl   
        cmpb $10, %cl           # compare the value at the current pointer in ecx to 10
        je return
        subb $48, %bl
        mull ten
        addl %ebx, %eax
        jmp converttoint
    return:
    
        movl %eax, endnum       # move eax to endnum  
    done:
        movl $EXIT,%eax        # safely exit
        movl $SUCCESS,%ebx
        int $0x80



