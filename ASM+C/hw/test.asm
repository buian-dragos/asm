bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll             ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 
    new_alphabet db "OPQRSTUVWXYZABCDEFGHIJKLMN",0
    anamere db "anaaremere",0
    format db "%s",0


; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx,10
        mov esi,anamere
        mov edi,anamere
        
        .change_loop:
            mov eax,0
            lodsb
            mov edx,eax
            sub edx,'a'
            mov eax,[new_alphabet + edx]
            stosb
        loop .change_loop
        
        push dword anamere
        push dword format
        call [printf]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
