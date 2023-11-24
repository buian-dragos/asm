bits 32


global _tost

                         
segment data public data use32

    ;new_alphabet db "OPQRSTUVWXYZABCDEFGHIJKLMN",0
    temp dd 0


segment code public code use32
_tost:
    ;change_alphabet(string,len)
    push ebp
    mov ebp,esp


    mov eax,[ebp + 8]
    mov esi,eax
    mov edi,eax

    mov [temp],eax
    lodsb
    add al,2
    stosb
    mov eax,[temp]

    mov esp,ebp
    pop ebp

    ret