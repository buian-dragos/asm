bits 32

global write        

extern fprintf,fopen,fclose
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    fd dd 0
    file_name db "max.txt",0
    acces_mode db "w",0
    format db "%x",0
    maxim dd 0
    return dd 0
    
segment code use32 class=code
    write:
        mov eax,[esp+4]
        mov [maxim],eax
        
        push dword acces_mode
        push dword file_name
        call [fopen]
        add esp,4*2
            
        mov [fd],eax

        push dword [maxim]
        push dword format
        push dword [fd]
        call [fprintf]
        add esp,4*3

        push dword [fd]
        call [fclose]
        add esp,4
      
        ret
