.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

write: # write ascii text
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $WRITE,  %eax    # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx    # %ebx: Moves STDOUT 
        # movl   $prompt_start,%ecx    # %ecx: moves the length into ecx
        # movl  $START, %edx      # %edx: moves the text being written into edx
        int   $0X80             # syscall
        ret                     # return 

read: # Read user input
# Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $READ,  %eax      # %eax: Moves the read syscall into eax
        movl  $STDIN, %ebx      # %ebx: Moves STDIN into ebx
        movl  $buffer, %ecx     # %ecx: Output is put into buffer  
        movl  $5, %edx          # %edx: The Maxium characters it will accept 5
        int   $0X80             # syscall
        ret                     # return 
exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80
buffer:
    .ascii " "
    .byte 10
number:
    .long 10

square:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %ecx
    movl %ecx, %eax
    mull %ecx       # number * number
    movl %eax, 8(%ebp)
    popl %ebp
    ret
squaresetup:

    ret
.text
    .globl _start
    _start:
    subl $4, %esp # reserve space for the stack frame
    movl number, %eax
    movl %eax, (%esp) # store the number of arguments in the stack frame
    movl $0, %eax
    call square
    movl (%esp), %eax
done:
    call exit

