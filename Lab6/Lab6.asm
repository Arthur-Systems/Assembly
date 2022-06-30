
 # @file main.asm
 # @author Arthur Wei  
 # @version Lab 5
 # @date 2022-06-26

 # @brief This file is the implementation of the Stack class.

# ! Registers

# ebx - The addition register. It stores the numbers that has already been added.
# ecx - 

.data
 

.text
    .globl _start
    _start:

    movl $0, %eax  # Set the start value
    movl $10, %ebx # Set the end value 
    movl $0, %ecx 

loop1:
    cmpl %eax, %ebx
    jge loop2
    jmp done

loop2:
    movl %eax, %ecx
    inc %eax
    jmp loop1

done: 
    nop
    nop

    # Program Output 
    
