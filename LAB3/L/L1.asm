bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 125
    b db 150
    c dw 15
    d db 2
    e dq 80

; our code starts here
segment code use32 class=code
    start:
        ; a+b/c-d*2-e =125+10-4-81=51
        ;b/c
        mov AL,[b]
        mov AH,0
        mov DX,0
        div word [c]
        mov BX,AX
        
        ;d*2
        mov AL,2
        mul byte [d]
        
       ;b/c-d*2
        sub BX,AX
        
        ;a+BX
        mov EAX,0 ;BX -> EAX
        mov AX,BX
        add EAX,[a]
        
        ;EAX-e (quad)
        mov EDX,0 ; EAX -> EDX:EAX
        
        sub EAX,[e] ;EAX-e and set CF
        sbb EDX,[e+4]
       
        ;final result EDX:EAX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
