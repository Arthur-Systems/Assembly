
# @file Lab8.asm
 # @author Arthur Wei  
 # @version Lab 8
 # @date 2022-06-30

 # @brief This file is the implementation of the Stack class.

# ! Registers

#
.data 
    binary:
        .word 0b10101010
    end:
        .word 0
    

.text 
    .globl _main
    _main:

    movw $binary, %ax
    OR $0xFFF, %ax
  

done:
    movw %ax, %bx
    nop

    








