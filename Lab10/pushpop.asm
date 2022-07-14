.text

.globl _start

_start:
     pushl %ebx
     pushl %eax

     movl $-1, %eax
     movl $-2, %ebx
     movl $0, %ecx
     movl $0, %edx

     pushl %eax
     pushl %ebx
     popl %ecx
     popl %edx

     popl %ebx
     popl %eax
done:
