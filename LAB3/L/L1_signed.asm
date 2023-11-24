bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; SIGNED
    a dd 125
    b db 120
    c dw 12
    d db 2
    e dq 80

; our code starts here
segment code use32 class=code
    start:
        ; a+b/c-d*2-e =125+10-4-80=51
        ;b/c
        mov AL,[b]
        cbw ;AL->AX
        cwd ;AX->DX:AX
        idiv word [c]
        mov BX,AX
        
        ;d*2
        mov AL,2
        imul byte [d]
        
       ;b/c-d*2
        sub BX,AX
        
        ;a+BX
        mov AX,BX
        cwde ;AX->EAX
        add EAX,[a]
        
        ;EAX-e (quad)
        cdq ; EAX -> EDX:EAX
        
        sub EAX,[e] ;EAX-e and set CF
        sbb EDX,[e+4]
       
        ;final result EDX:EAX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
