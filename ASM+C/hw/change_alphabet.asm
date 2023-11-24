bits 32


global _change_alphabet

                         
segment data public data use32

    new_alphabet db "OPQRSTUVWXYZABCDEFGHIJKLMN",0
    temp dd 0


segment code public code use32
_change_alphabet:
    ;change_alphabet(string,len)
    push ebp
    mov ebp,esp


    mov eax,[ebp + 8]
    mov esi,eax
    mov edi,eax

    mov ecx,[ebp + 12]

    mov [temp],eax
    pushad
    .change_loop:
        mov eax,0
        lodsb
        mov edx,eax
        sub edx,'a'
        mov eax,[new_alphabet + edx]
        stosb
    loop .change_loop
    popad
    mov eax,[temp]
    mov esp,ebp
    pop ebp

    ret

    
