bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global calculate_new_string        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 dd 0
    s2 dd 0

; our code starts here
segment code use32 class=code
    calculate_new_string:
        ; ...
        
        mov eax, [esp+4]
        mov [s2],eax
        mov eax, [esp+8]
        mov [s1],eax
        mov edx, 0
        mov esi, [s1]
        mov edi, [s2]
        .loop:
            cmp ebx,0
            je .finish_loop
            lodsw
            sub ebx,1
            mov cl,8d
            shr eax,cl
            and eax, 00000000000000000000000000001111b 
            mov dword[s2+edx],eax
            loop .loop
        
        .finish_loop:
        ret
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
