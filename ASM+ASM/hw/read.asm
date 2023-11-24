bits 32

global read        

extern printf, scanf
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data
    message db "Length of the string: ",0
    format db "%d",0
    len dd 0
    temp dd 0
    n dd 0
    return dd 0
    
    
segment code use32 class=code
    read:
        
        push dword message
        call [printf]
        add esp,4
        
        push dword len
        push dword format
        call [scanf]
        add esp,4*2
        
        mov ecx,[len]
        jecxz .skip_loop
        mov edi,[esp+4]
        .read_loop:
            mov [temp],ecx
            
            push dword n
            push dword format
            call[scanf]
            add esp,4*2
            
            mov eax, [n]
            stosd
        
            mov ecx,[temp]
        loop .read_loop
        
        mov eax,[len]
        
        .skip_loop:
        ret
