bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               
import exit msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a resd 15
    temp dd 0
    format db "%d",0
    
; our code starts here
segment code use32 class=code
    start:
        mov edi,a
        test_loop:
            push dword temp
            push dword format
            call [scanf]
            add esp,4*2
            
            mov eax,[temp]
            stosd
                
            cmp dword [temp],0
        jne test_loop
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
