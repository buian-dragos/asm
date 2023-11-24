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
    b dw 40

; our code starts here
segment code use32 class=code
    start:
        ; (b/a*2+10)*b-b*15
        ;b/a*2
        mov ax, [b]
        div byte [a] ;AX/a -> AL AX%a->AH ; AL=b/a
        mov BH, 2
        mul BH ;AL*BH -> AX=b/a*2
        add ax,10 ;AX=(b/a*2+10)
        
        mul word [b] ;AX=(b/a*2+10)*b -> DX:AX -> EBX
        push DX
        push AX
        pop EBX ;EBX=(b/a*2+10)*b
        
        ;b*15 = word*word
        mov AX, 15
        mul word [b] ;AX*b -> DX:AX = b*15
        push DX
        push AX
        pop EAX ;EAX=b*15
        
        sub EBX,EAX ; EBX=(b/a*2+10)*b-b*15
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
