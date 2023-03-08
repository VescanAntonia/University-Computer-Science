bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
        string db 'AnA rEnunTa La'
    string_litere_mari times 100 db 0
    string_litere_mici times 100 db 0
    format db "%s",44,0
    format2 db "%s",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,string
        mov edi,0
        mov edx,0
        mov ecx,0
        mov ebx,0
        number:
            lodsb
            cmp al,0
            je .done_first
            inc ebx
            
        jmp number
        .done_first:
        mov esi, string
        mov edi, 0
        .my_loop:
            cmp ebx,0
            je done
            dec ebx
            mov al, [string+edi]
            inc edi
            cmp al,'a'
            jb .check_if_big_letter
            
            cmp al,'z'
            ja .check_if_big_letter
            
            mov [string_litere_mici+edx], al
            inc edx
            jmp .my_loop
            
            .check_if_big_letter:
                cmp al,'A'
                jb .my_loop
                
                cmp al, 'Z'
                ja .my_loop
                mov [string_litere_mari+ecx],al
                inc ecx
        jmp .my_loop
        done:
        push dword string_litere_mici
        push dword format
        call [printf]
        add esp,4*2
        
        
        push dword string_litere_mari
        push dword format2
        call[printf]
        add esp,4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
