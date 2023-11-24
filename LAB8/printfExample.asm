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
    n dd 3
    m dd 7
    format db "I have %d apples and %d cakes.",0
    
    ;fd=fopen("file.txt","r")
    fn db "file.txt",0  ;file name
    mode db "r",0
    fd dd -1            ;file descriptor

; our code starts here
segment code use32 class=code
    start:
        ; ...
        pushad          ;saves all reg on stack
        push dword [m]
        push dword [n]
        push format
        call [printf]
        add esp,4*3
      
        popad           ;restores EAX,ECX,EDX
    
        ;scanf
        push mode
        push fn
        call [fopen]
        add esp*2
        mov [fd],eax
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
