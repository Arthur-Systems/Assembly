.data            
    .equ STDIN,0 
    .equ STDOUT,1  
    .equ READ,0 
    .equ WRITE,4
    .equ EXIT,1
    .equ SUCCESS,0

    string:                
        .asciz "hello, wor1d\n"

.text            
    .globl _start
    _start:
        movl $string, %ecx 
    cmpb:
        cmpb $0, (%ecx)   
        jne LETTERSEACH          
        je done           
    increase:
        inc %ecx          
        jmp comparebyte
    LETTERSEACH:  
        movl $WRITE, %eax  
        movl $STDOUT, %ebx 
        movl $1, %edx      
        int $0X80          
        movl %ecx, %eax    
        jmp increase       
    done:
        movl $EXIT, %eax    
        movl $SUCCESS, %ebx 
        int $0X80           

     
        



        


    

    
    