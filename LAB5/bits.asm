bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A- byte, B- word, C- doubleword
    A db 11010110b
    B dw 1001011000101000b
    C resd 1
    
; our code starts here
segment code use32 class=code
    start:
        ; (1) the bits 24-31 of C are the same as the bits of A
        ; (2)the bits 16-23 of C are the invert of the bits of the lowest byte of B
        ; (3)the bits 10-15 of C have the value 1
        ; (4)the bits 2-9 of C are the same as the bits of the highest byte of B
        ; (5)the bits 0-1 both contain the value of the sign bit of A
        
        ;(1)
        mov EAX,0
        mov AL,[A]  ;EAX=0000 0000 0000 0000 0000 0000 1101 0110b
        mov CL,8
        rol EAX,cl  ;EAX=0000 0000 0000 0000 1101 0110 0000 0000b ;we move (1) so we can have space for (2)
        
        ;(2)
        mov BX,[B]  ;BX=B
        xor BL,11111111b    ;inverts the lowest byte of B
        mov AL,BL   ;EAX=0000 0000 0000 0000 1101 0110 1101 0111b
        
        
        ;(3)
        mov CL,6    
        rol EAX,CL      ;EAX=0000 0000 0011 0101 1011 0101 1100 0000b
        or AL,00111111b ;EAX=0000 0000 0011 0101 1011 0101 1111 1111b
        
        ;(4)
        mov CL,8                    
        rol EAX,CL ;EAX=0011 0101 1011 0101 1111 1111 0000 0000b
        or AL,BH   ;EAX=0011 0101 1011 0101 1111 1111 1001 0110b
        
        ;(5)
        mov CL,1
        mov DL,[A]
        rcl DL,CL   ;the sign bit of A will be moved to the right and will be saved in CF
        mov DL,0    ;we need to change the last 2 bits of DL to the sign of A, we do this by addig the CF to DL twice
        adc DL,0    ;DL=0000 0001  
        mov BL,DL
        rol DL,CL   
        add DL,BL   ;DL=0000 0011
        
        mov CL,2                   
        rol EAX,CL  ;EAX=1101 0110 1101 0111 1111 1110 0101 1000b
        or AL,DL    ;EAX=1101 0110 1101 0111 1111 1110 0101 1011b - the last 2 digits become the sign of A
        
        
        ;moving everything in C
        mov [C],EAX ;the result in this case is 1101 0110 1101 0111 1111 1110 0101 1011b = D6D7FE5Bh
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
