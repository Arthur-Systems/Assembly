
# @file Lab8.asm
 # @author Arthur Wei  
 # @version Lab 8
 # @date 2022-06-30

 # @brief This file is the implementation of the Stack class.

# ! Registers

.data     # Define Variables
    start:
        .word 0b111111
   

    end:
        .word 0

.text 
    .globl _main
     
    _main:
    movw $0b1010101010101010, %ax
    xorw $0xffff, %ax
    
done:
    movw %ax, %bx
    nop

    








