# @author Arthur Wei  
# @version Lab 11
# @date 2022-07-14

# ! Register use list:

# eax: This register is used to store the string to be printed. It will be increased if the string hasn't ended. 
# ebx: Not used in this program except as system call stdout discriptor.
# ecx: This register is mostly used to print the string in the system call. It will recopy its value to eax to be rerun again.
# edx: edx is not really used in the program except as the number of bytes to write.

.section .data             # data section
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,0 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    string:                # string section
        .asciz "hello, wor1d\n"

.section .text             # text section (executable code) 
    .globl _start
    _start:
        movl $string, %eax # load the string into eax
    loop1:
        cmpb $0, (%eax)    # compare the current byte of the string with 0
        jne Write          # if not equal, jump to the Write function
        jmp done           # if equal, jump to done
    increase:
        inc %eax           # increase the pointer to the string
        jmp loop1
    Write:
        movl %eax, %ecx    # copy the pointer to ecx
        movl $WRITE, %eax  # System call number 4
        movl $STDOUT, %ebx # stdout has descriptor
        movl $1, %edx      # number of bytes to write
        int $0X80          # System call
        movl %ecx, %eax    # Restore pointer
        jmp increase       # jump to the function that increases the pointer
    done:
        movl $EXIT, %eax    # System call number 1
        movl $SUCCESS, %ebx # exit status
        int $0X80           # System call

     
        



        


    

    
    