;Being given a string of doublewords, build another string of doublewords which will include only the doublewords from the given string which have an even number of bits with the value 1.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf       ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
                          
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 dd 01100010000001101001001111101111b,00101101011101000100111010111001b,01110110100010011110100010011100b
    ;        620693EFh     da 16                2D744EB9h       nu  17          7689E89C                 da 16
    len equ ($-s1)/4 ;length of s1
    s2 resd len
    ct db 0
    
    k dd 0
    message db "The doublewords with an even number of bits with value 1 are: ",0
    format db "%x ",0
    testFormat db " %d",0
    
; our code starts here
segment code use32 class=code
    start:
        ; Being given a string of doublewords, build another string of doublewords which will include only the doublewords from the given string which have an even number of bits with the value 1.
        mov ecx,len
        jecxz skipLoop
        mov esi,s1
        mov edi,s2
        cld
        loop1:                      ;loop1 goes the string of doublewords
            mov byte [ct],0
            mov eax,0
            lodsd                   ;we load the current dword into eax
           
            mov ebx,ecx
            mov ecx,32
            
            loop2:                  ;loop2 is used for counting the number of bits with value 1 of each dword
                rol eax,1
                adc byte [ct],0     ;add 1 into [ct] if the but that was rolled to the left was 1
            loop loop2
            
            mov edx,eax             ;we save the current dword into edx
            mov eax,0
            mov al,[ct]
            mov cl,2
            div cl
            cmp ah,0                ;we check if the current dword has an even number of bits with value 1
            jnz doNotAdd
                mov eax,edx
                stosd               ;we add the dword in the second string
                inc dword [k]
            doNotAdd:
            
            mov ecx,ebx
        loop loop1
        skipLoop: 
        
        ;printf("The doublewords with an even number of bits with value 1 are %x);
        push dword message
        call [printf]
        add esp,4*1
  
        mov ecx,[k]
        mov esi,0
        printLoop:
            mov ebx,ecx
            push dword [s2+esi]
            push dword format
            call [printf]
            add esp,4*2
            mov ecx,ebx
            add esi,4
        loop printLoop
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
