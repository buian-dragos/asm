bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fscanf, printf, fclose
import exit msvcrt.dll    
import fopen msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    n dd 0
    num dd 0
    base_8 dd 0
    quo dw 0
    rem dw 0
    p dw 1
    temp dd 0
    eight dw 8
    ten dw 10
    
    file_name db "input.txt",0
    acces_mode db "r",0
    file_descriptor dd 0
    
    format db "%d",0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword acces_mode
        push dword file_name
        call [fopen]
        add esp,4*2
        
        push dword n
        push dword format
        push dword [file_descriptor]
        call [fscanf]   
        
        mov ecx,[n]
        reading_loop:
            mov [temp],ecx
        
            push dword num
            push dword format
            push dword [file_descriptor]
            call [fscanf]
            
           
            mov dx,[num]
            mov ax,[num+2]
            
            mov dword [base_8],0
            mov word [p],1
            conversion_loop:
                div word [eight]
                mov [rem],dx
                mov [quo],ax
                
                mov ax,[rem]
                mul word [p]
                push dx
                push ax
                pop dword [base_8]
                
                mov ax,[p]
                mul word [ten]
                mov [p],ax
                
                mov dx,0
                mov ax,[quo]
                
                cmp word [quo],8
            ja conversion_loop
            
            push dword [base_8]
            push dword format
            call [printf]
            add esp,4*2
            
            mov ecx,[temp]
            dec ecx
        jnz reading_loop
        ;loop reading_loop
        
        
        push dword [file_descriptor]
        call [fclose]
        add esp,4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
