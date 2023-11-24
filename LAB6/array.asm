bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; sum of even elements
    s1 db 1,2,3,4,5,6,7,8,9,10
    lens1 equ $-s1
    two db 2
    ten db 10
    s2 times lens1 dw 0     ;add digit 7 to each element of s1 17,27,37...
    evenSum db 0
    oddSum db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; construct s2 by adding digit 7 ata the end of elements from s1
        mov ecx, lens1
        mov esi,0   ;index for s1
        mov edi,0   ;index for s2
        jecxz end_loop
        add_7:
            mov al,[s1+esi]
            mul byte [ten] ;ax=al*10
            add ax,7
            mov [s2+edi],ax
            inc esi
            add edi,2
        loop add_7
        end_loop:
        
        
        
        
        mov bl,0    ;even sum
        mov bh,0    ;odd sum
        mov ecx,lens1   ;number of steps of loop - ECX; we need the number of steps to be the length
        mov esi,0
        jecxz skip_loop
        sum_loop:
            mov al,[s1+esi] ;s1[esi]
            mov ah,0 ;al->ax unsigned
            div byte [two] ;al=ax/2 ah=ax%2
            cmp ah,0       ;check if even/odd
            jne do_not_add ;jump over the add if its odd
                add bl,[s1+esi]
                jmp over_odd
            do_not_add:
                add bh,[s1+esi]
            over_odd:
            inc esi
        loop sum_loop
        skip_loop:
        mov [evenSum],bl
        mov [oddSum],bh
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
