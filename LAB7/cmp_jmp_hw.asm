;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the elements of A in reverse order.

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
    A db  2, 1, -3, 0
    lenA equ $-A
    B db 4, 5, 7, 6, 2, 1
    lenB equ $-B
    R times (lenA+lenB) db 0
    lenR equ $-R

    
; our code starts here
segment code use32 class=code
    start:
        ; Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the elements of A in reverse order.
        
        mov ecx,lenB ;we need to add the elemnt of B in reverse order first
        jECXz skipLoop
        mov edi,0
        mov esi,lenB
        elementsB:
            dec esi
            mov al,[B+esi]
            mov [R+edi],al ;the loop takes the elements of B in reverse order
            inc edi
        loop elementsB
        skipLoop:
        
        mov ecx,lenA ;we need to add the elemnt of A in reverse order
        jECXz skip_loop
        mov edi,lenB
        mov esi,lenA
        elementsA:
            dec esi
            mov al,[A+esi]
            mov [R+edi],al ;the loop takes the elements of A in reverse order
            inc edi
        loop elementsA
        skip_loop:
        ;string R now has the elementf of B in reverse + the elements of A in reverse - 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
