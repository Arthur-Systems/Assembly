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
        .byte 10                

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
        movl $buffer, %eax      # copy the input into the eax register  %eax:contains the input of the user 
        movl $0, %edx           # reset edx to 0

    countchar:                  # counts the number of characters in any given string. 
        cmpb $10, (%ecx)        # compare the value at the current pointer in ecx to 10
        jne increase            # if its not equal, jump to increase
        je converttoint         # if equal, jump to convert to int
    increase:                   
        inc %ecx                # incrase the pointer in ecx
        inc %edx                # increase edx %edx: Will be the counter of the program so the program knows how long the input is and knows when to terminate
        jmp countchar           # jump to countchar

    converttoint:               # converts ascii to int
        movl %eax, %ecx         # copy eax to ecx
        movl $0, %eax           # reset eax to 0
        movl %edx, %ebx         # copy edx to ebx
        movl $0, %edx           # reset edx to 0
        jmp math1               # jump to math1

    math1:
        subb $48, (%ecx)        # subtract 48 bytes from the value in ecx 
        addb (%ecx), %al        # add the current value in ecx to al 
        inc %ecx                # increase eax
        decl %ebx               # decrease ebx 
        cmpl $0, %ebx           # compare ebx to 0
        jne multiply            # if not equal, jump to multiply
        je return               # if euqal, jump to return
    multiply:
        mulb ten                # multiply by 10 
        jmp math1               # jump to math

    return:
        movl %eax, endnum       # move eax to endnum  
        jmp done                # jump to done
    done:
        movl $EXIT,%eax        # safely exit
        movl $SUCCESS,%ebx
        int $0x80



