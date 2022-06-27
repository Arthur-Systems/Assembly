
 # @file main.asm
 # @author Arthur Wei  
 # @version Lab 5
 # @date 2022-06-26

 # @brief This file is the implementation of the Stack class.

# ! Registers

# eax 
# ebx
# ecx

data:     # Define Variables
    x:
        .long 1 
        .long 2
        .long 3
        .long 4
        .long 0
        .long 1 
        .long 2
        .long 3
        .long 4

        
    sum:
        .long 0

text:  # Define Functions
    .globl _main # Declare _main as a global function
    _main: 

    movl $0, %ebx   # addition registery 
    movl $x, %ecx   # Pointer 

top:
    addl (%ecx), %ebx  # add the value at the pointer to the addition registery
    addl $4, %ecx  # add to the pointer to the counter
    cmpl $0, (%ecx)
    jne top

done: movl %ebx, sum
    
