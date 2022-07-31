# Register Use List:
# eax: eax is only used for multication and storing the result.
# ebx: ebx (bl) is used for storing each byte of ecx.
# ecx: ecx is used to store the user inputted ascii number. 
# edx: edx is only used for the syscalls.  

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
        movl  $prompt_start,%ecx    # %ecx: moves the length into ecx
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
    
    converttoint:                # converts ascii to int
        inc %ecx
        movb (%ecx), %bl   
        cmpb $10, (%ecx)         # compare the byte at the current location of the pointer at ecx to 10
        je return
        subb $48, %bl            # subtract 48 bytes from the byte in ecx to get the int value of the ascii number
        mull ten                 # multiply the int value of the ascii number by 10
        addl %ebx, %eax
        jmp converttoint
    return:
        movl %eax, endnum       # move eax to endnum  
    done:
        movl $EXIT,%eax         # safely exit
        movl $SUCCESS,%ebx
        int $0x80



