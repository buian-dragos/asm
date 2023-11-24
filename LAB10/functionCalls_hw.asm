;Two numbers a and b are given. Compute the expression value: (a/b)*k, where k is a constant value defined in data segment. Display the expression value (in base 2).
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll   ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    k dd 7
    
    copy_edx dd 0
    copy_eax dd 0
    temp dd 0
    
    format db "%d", 0
    message_a db "a= ",0
    message_b db "b= ",0
    message db "Result: ",0
    binary db "b",0
    
; our code starts here
segment code use32 class=code
    start:
        ; Two numbers a and b are given. Compute the expression value: (a/b)*k, where k is a constant value defined in data segment. Display the expression value (in base 2).
        push dword message_a
        call [printf]
        add esp,4
        
        push dword a
        push dword format
        call [scanf]        ;reading a
        add esp,4*2
        
        push dword message_b
        call [printf]
        add esp,4
        
        push dword b
        push dword format
        call [scanf]        ;reading b
        add esp,4*2
        
        mov edx,0
        mov eax,[a]         ;(a/b)
        div dword [b]       ;remainder - edx, quotinent - eax
        
        mov edx,0
        mul dword [k]       ;result is stored in edx:eax
        
        mov [copy_edx],edx  ;registers edx and eax will be modified when functions are called
        mov [copy_eax],eax
            
        push dword message
        call [printf]
        add esp,4
        
        
        
        mov ecx,32
        printEDX:
            rol dword [copy_edx],1
            mov ebx,0
            adc ebx,0
            mov [temp],ecx
            push ebx
            push dword format
            call [printf]
            add esp,4*2
            mov ecx,[temp]
        loop printEDX
        
        mov ecx,32
        printEAX:
            rol dword [copy_eax],1
            mov ebx,0
            adc ebx,0
            mov [temp],ecx
            push ebx
            push dword format
            call [printf]
            add esp,4*2
            mov ecx,[temp]
        loop printEAX
        
        push dword binary
        call [printf]
        add esp,4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
