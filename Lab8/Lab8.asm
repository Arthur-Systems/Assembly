
# @file Lab8.asm
# @author Arthur Wei  
# @version Lab 8
# @date 2022-07-09

# @brief This program transfers binary data from one register to another one by one. 

# ! Register Use List
# ax - ax is the source register where the start binary data is stored. It will later be copyed to the destination register
# bx - bx is the destination register where the binary data will be stored.
# cx - cx is the counter register. It will be shifted to the left by 1 bit each loop to point to each bit in the ax register. 
# dx - dx is the temporary register used to run and store the value of the AND operation of the dx register and the ax register.

.data     # Define Variables
    start:
        .word 0b1010101010101010
    mask: 
        .word 0b1

.text 
    .globl _main
     
    _main:
        movw start, %ax # Load the start binary data into the ax register
        movw mask, %dx  # Load the value in the lable mask into dx register
        movw %dx, %cx   # copy the value in dx into cx
    loop1:
        movw %cx, %dx   # Reset the dx register 
        andw %ax, %dx   # AND dx with ax
        cmpw %bx, %ax   # Compare ax with bx
        jne shift       # If not equal, jump to shift 
        jmp done        # Else, jump to done
    shift:
        addw %dx, %bx   # Add the current bit into bx
        shlw $1, %cx    # Shift cx left by 1 to get the next bit
        jmp loop1       # Go back to loop1
    done:
        nop             # no operation
        nop             # no operation




# Program output
#
# Breakpoint 1 at 0x401020
# (gdb) r
# (gdb) p /t $ax
# $1 = 1010101010101010
# (gdb) p /t $bx
# $2 = 0
# (gdb) c
# (gdb) p /t $ax
# $1 = 0
# (gdb) p /t $bx
# $2 = 1010101010101010
# (gdb) q


