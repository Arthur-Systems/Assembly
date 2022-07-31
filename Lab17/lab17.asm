.data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,3 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

main_string:
    .ascii "Hello World!\n"
substring:
    .ascii "Hello"

.text
    .globl _start
    _start:
        subl $8, %esp # reserve space for the stack frame
        movl main_string, %eax
        movl %eax, (%esp) # store the number of arguments in the stack frame
        movl substring, %eax
        movl %eax, 4(%esp) 
        movl $0, %eax
        call find_string


    done:
        call EOP           # prints a new line at the end of the program
        call exit

    write: # write ascii text
     # Registers being replaced: %eax, %ebx, %ecx, %edx
        movl  $WRITE,  %eax     # %eax: Moves the write syscall into eax
        movl  $STDOUT, %ebx     # %ebx: Moves STDOUT 
        # %ecx %edx: will be passed in exterinally
        int   $0X80             # syscall
        ret                     # return 

    find_string:
        pushl %ebp
        movl %esp, %ebp



    EOP: # end of program prints a new line
        movl $1, %edx
        movl $EOL, %ecx
        call write
        ret

    exit: # exit the program
        movl $EXIT,%eax
        movl $SUCCESS,%ebx
        int $0x80