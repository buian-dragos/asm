bits 32 ; assembling for the 32 bits architecture
;a-(7+x)/(b*b-c/d+2); a-doubleword; b,c,d-byte; x-qword


; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; signed
    a dd 110
    b db 7
    c db 15
    d db 5
    x dq 89 

; our code starts here
segment code use32 class=code
    start:
        ; a-(7+x)/(b*b-c/d+2) 110-(7+89)/(49-15/5+2)=110-96/48=108
        mov AL,[b]
        IMUL byte [b] ;AX=b*b
        mov BX,AX ;BX=b*b
        mov AL,[c]
        cbw ;AX=[c]
        IDIV byte [d] ;AX=c/d AL<-quotinent
        cbw
        sub BX,AX ;BX=b*b-c/d
        add BX,2 ;BX=b*b-c/d+2
        mov AX,BX
        cwde
        mov EBX,EAX ;EBX=BX
        mov EAX,[x]
        mov EDX,[x+4] ;EDX:EAX=x
        add EAX,7
        adc EDX,0 ;EDX:EAX=x+7
        IDIV EBX ;EDX:EAX=(x+7)/(b*b-c/d) EAX<-quotinent
        mov EBX,EAX
        mov AL,[a]
        cbw
        cwde ;EAX=a
        sub EAX,EBX ;EAX=a-(7+x)/(b*b-c/d+2)
        ;FINAL result is stored in EAX
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
