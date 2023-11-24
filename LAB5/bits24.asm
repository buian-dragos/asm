bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; M,MNew - doubleword
    M dd 11010110110101111111111001011011b
    MNew resd 1

; our code starts here
segment code use32 class=code
    start:
        ; the bits 0-3 a of MNew are the same as the bits 5-8 a of M
        ; the bits 4-7 a of MNew have the value 1
        ; the bits 27-31 a of MNew have the value 0
        ; the bits 8-26 of MNew are the same as the bits 8-26 a of M
        mov EAX,0
        mov EBX,[M]
        and BX,0000000111100000b    ;adds the bits 5-8 of M into BX
        mov CL,5
        ror BX,CL   ;the last 4 bits of BX are bits 5-8 of M
        mov AL,BL   ;the last 4 bits of EAX are bits 5-8 of M
        
        or AL,11110000b ;bits 4-7 of EAX are 1
        
        ;because we moved 0 into EAX, bits 27-31 are already 0

        mov EBX,[M]
        and EBX,00001111111111111111111100000000b   ;adds into EAX the bits 8-26 of M
        or EAX,EBX ;EAX has the final result - 00000110110101111111111011110010b - 6D7FEF2h
        
        mov [MNew],EAX
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
