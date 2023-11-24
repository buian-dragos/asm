;[(a-d)+b]*2/c      a,b,c,d-byte
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
    b db 5
    c db 11
    d db 4
    
    
; our code starts here
segment code use32 class=code
    start:
        ; [(a-d)+b]*2/c     (10-4+5)*2/11=11*2/11=2
        mov AL,[a]
        sub AL,[d]  ;AL=a-d
        add AL,[b]  ;AL=(a-d)+b
        mov BL,2
        mul BL      ;AX=[(a-d)+b]*2
        mov BL,[c]
        div BL      ;AX=[(a-d)+b]*2/c (AL=[(a-d)+b]*2/c, AH=[(a-d)+b]*2%C)
        ;FINAL RESULT is stored in AX (AL-quotient and AH-remainder)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
