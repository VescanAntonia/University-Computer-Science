bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 4
    b dw 9
    c dd 123
    d dq 1122

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; a - byte, b - word, c - double word, d - qword - Unsigned representation
        ; (b+c+a)-(d+c+a)
        mov eax, dword[d]
        mov edx, dword[d+4]
        add ax, word[c]
        adc dx, word[c+2]
        add al, byte[a]
        
        mov ebx, eax
        mov ecx,edx
        
        mov ax, [c]
        mov dx, [c+2]
        push dx
        push ax
        pop eax
        mov edx,0
        add ax, word[b]
        add al, byte[a]
        
        sub eax,ebx
        sbb edx, ecx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
