bits 32

global maxim        

segment data use32 class=data
    last dd 0
    max dd 0
    return dd 0

segment code use32 class=code
    maxim:
        mov ecx, [esp+8]
        mov esi, [esp+4]
        
        lodsd
        mov [last], eax
        mov [max], eax
        dec ecx
        
        jecxz .skip_loop
        .max_loop:
           lodsd
           cmp eax, [last]
           jle .no_change
                mov [max],eax
           .no_change:
           mov [last],eax
        loop .max_loop
        .skip_loop:
        
        mov eax,[max]

        ;mov [esp+12],eax
        
        ret

