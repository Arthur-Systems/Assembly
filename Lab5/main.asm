#program created by Arthur Wei 

data: 
    x:
        .long 1 
        .long 2
        .long 3
        .long 4
        .long 0
        
    sum:
        .long 0

text: 
    .globl _main
    _main:

    movl $5, %eax   #counter
    movl $0, %ebx   #addition registery 
    movl $x, %ecx   #Pointer 

top:
    addl (%ecx), %ebx 
    addl $4, %eax
    decl %eax
    jnz top

done: movl %ebx, sum
    
