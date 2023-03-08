bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
import exit msvcrt.dll

;check if a string is a palindrome
segment data use32 class=data

    a db "cojoc barba"
    lena equ $-a
    rez times lena db 0
; our code starts here
segment code use32 class=code
start:
    
    mov ebx,0
    mov ecx, lena
    jecxz fin
    mov esi, a
    loop1:
    mov dl,0
        get_the_letters:
            mov eax, 0
            lodsb; store each byte from the string into al, convert it to dword, push to stack
            cmp al,20h
            je check_if_palindrom
            add dl,1h
            push eax
        loop get_the_letters
        
    check_if_palindrom:
        mov edi, a
        mov dh,1
        ;sub ecx,edx
        cmp dl,0
        je verifica
        loop2:
            pop eax ; since the string was pushed element by element on the stack, when removing it, it will be in reverse order
            scasb ; we can compare what is on the stack with the current element pointed by edi
            je a_palindrome
                mov dh,-1
            a_palindrome:
            sub dl,1h 
        jnz loop2
        verifica:
            ;cmp dh,0
            ;jne loop1
            mov byte[rez+ebx],dh
            inc  ebx
    loop loop1
    fin:
    push dword 0
    call [exit]

