;A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all digits from the text with character 'C'. Create a file with the given name and write the generated text to file.
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll         
import fopen msvcrt.dll         
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    file_name db "output.txt",0
    acces_mode db "w",0
    file_descriptor dd -1
    
    format db "%s",0
    
    text db "r0an1dom2T7EXT&*4*(!"
    len equ $-text
    generated_text resb len
    

; our code starts here
segment code use32 class=code
    start:
        ; A file name and a text (defined in data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all digits from the text with character 'C'. Create a file with the given name and write the generated text to file.
        mov esi,text
        mov edi,generated_text
        mov ecx,len
        text_loop:
            lodsb
            cmp al,'0'
            jb not_digit
                cmp al,'9'
                ja not_digit
                    mov al,'C'
            not_digit:
                stosb
        loop text_loop
        
        push dword acces_mode
        push dword file_name
        call [fopen]
        add esp,4*2
        
        mov [file_descriptor],eax
        
        push dword generated_text
        push dword format
        push dword [file_descriptor]
        call [fprintf]
        add esp,4*3
        
        push dword [file_descriptor]
        call [fclose]
        add esp,4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
