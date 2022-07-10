.data

sourceword:
    .word   0xAB
wordmask:
    .word   0xCF
operand:
    .long   0xAA

.text

.globl _start

_start:
     movw  sourceword, %ax
     movw  %ax, %bx
     xorw  %cx, %cx
#  What's in ax?
#  What's in bx?
#  What's in cx?

     andw  wordmask, %ax
#  What's in ax?
     orw   wordmask, %bx
#  What's in bx?
     xorw  wordmask, %cx
#  What's in cx?

     movl  operand, %eax
     movl  %eax, %ebx
     movl  %eax, %ecx
#  What's in eax?
#  What's in ebx?
#  What's in ecx?

     shll  $3,%eax
#  What's in eax?

     rorl  $4,%ebx
#  What's in ebx?

     sarl  %ecx
#  Now what's in ecx?

done:

