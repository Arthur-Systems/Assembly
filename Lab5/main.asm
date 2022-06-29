
 # @file main.asm
 # @author Arthur Wei  
 # @version Lab 5
 # @date 2022-06-26

 # @brief This file is the implementation of the Stack class.

# ! Registers

# ebx - The addition register. It stores the numbers that has already been added.
# ecx - The stack pointer, which points to the address of the lable X. 

.data     # Define Variables
    x:
        .long 1 
        .long 2
        .long 3
        .long 4
        .long 5
        .long 6
        .long 0 # all values past 0 arnt not factored in. 

    sum:
        .long 0

.text  # Define Functions
    .globl _main # Declare _main as a global function
    
    _main: 
    movl $0, %eax   # addition registery 
    movl $x, %ebx   # Pointer 

top:
    addl (%ebx), %eax   # add the value at the pointer to the addition registery
    addl $4, %ebx       # add to the pointer to the counter
    cmpl $0, (%ebx)     # compares the value at the pointer to 0
    jne top             # if not 0, go to top of loop

done: 
    movl %eax, sum      # move the addition registery to the eax register
    nop                 # No Operation

   

# Program Output 
# (gdb) n

# 42          nop                 # No Operation

# (gdb) p (int) sum

# $2 = 21