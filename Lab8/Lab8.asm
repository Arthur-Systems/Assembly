
# @file Lab8.asm
 # @author Arthur Wei  
 # @version Lab 8
 # @date 2022-06-30

 # @brief This file is the implementation of the Stack class.

# ! Registers
# ax
# bx
# cx 
# dx

.data     # Define Variables
    start:
        .word 0b1010101010101010

.text 
    .globl _main
     
    _main:
        movw start, %ax # Load start into ax
        # not %ax         # Invert ax
        movw %ax, %cx   # Copy the value of ax to cx
        movw $1, %dx    # Load 1 into dx counter
    count:
        cmp %ax,0       # Compare ax and dx
        jne counter     # If not equal, jump to loop2
        je Reseter        # If equal, jump to loop4
    loop1: 
        jmp loop2    # jump to loop2
    counter:
        shrw $1, %ax    # Shift ax left by 1
        incw %dx         # Increment dx
        jmp loop1       # Jump to loop1
    Reseter:
        movw %cx, %ax   # Copy the value of cx to ax
        incw %cx
        subw %cx, %dx # Subtract cx from dx
        jmp loop1
    loop2: 
        decw %dx
        shrw (%dx), %ax  
        movw %dx, %cx
        shlw (%cx), %ax
        addw %ax, %bx
        jmp loop2       # Jump to loop1
        jmp done
      

done:
        movw $0, %ax    # Load 0 into ax
        nop
        ret             # Return









