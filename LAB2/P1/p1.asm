;(10*a-5*b)+(d-5*c) a,b,c - byte, d - word

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
    a db 10
    b db 7
    c db 20
    d dw 300
; our code starts here
segment code use32 class=code
    start:
        ; (10*a-5*b)+(d-5*c)   (100-35)+(300-100)=265
        mov AL,10
        mul byte [a] ;AX=10*a
        mov BX,AX   ;BX=10*a
        mov AL,5
        mul byte [b] ;AX=5*b
        sub BX,AX ;BX=10*a-5*b
        mov AL,5
        mul byte [c] ;AX=5*c
        sub [d],AX  ;d=d-5*c
        add BX,[d]  ;BX=(10*a-5*b)+(d-5*c)
        ;FINAL RESULT is stored in BX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
