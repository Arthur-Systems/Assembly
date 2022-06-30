
 # @file main.asm
 # @author Arthur Wei  
 # @version Lab 5
 # @date 2022-06-26

 # @brief This file is the implementation of the Stack class.

# ! Registers

# eax - This is the starting value register. It will start at 0 and
# It will be incsented by 1 each time it is detected that it is less then the end value.

# ebx - This is the ending value register. eax is compared to this register.

.data
 

.text
    .globl _start
    _start:

    movl $0, %eax  # Set the start value
    movl $10, %ebx # Set the end value 

loop1:
    cmpl %eax, %ebx
    jg loop2    # If eax is less than ebx, jump to loop2
    jmp done    # If top false then jump to done

loop2:
    inc %eax     # add 1 to the start value
    jmp loop1

done: 
    nop         # nop is a no-operation instruction.
    nop

# see text doucmentation for code output and proof of correctness.