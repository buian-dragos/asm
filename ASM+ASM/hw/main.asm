bits 32

global start        

extern exit, read, maxim, write,printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    string_adress resd 100
    string_length dd 0
    max dd 0
    formad db "%d",0

segment code use32 class=code
    start:
        push dword string_adress    ;allocating space for the output parameters
        call read
        add esp,4
        
        
        push dword eax  ;string length
        push dword string_adress
        call maxim
        add esp,4*2
        
        mov [max],eax
        
        push dword [max]
        call write
        add esp,4
    
        push    dword 0      
        call    [exit]       
