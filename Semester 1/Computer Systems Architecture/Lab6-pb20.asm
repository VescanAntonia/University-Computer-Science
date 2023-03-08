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
    sir db "abccba barba"
    dim_sir equ ($-sir) ; compute the length of the string in dim_sir
    rez times dim_sir db 0 ; reserve dim_sir bytes for the destination string and initialize it
    index times dim_sir db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Being given a string of bytes representing a text (succession of words separated by spaces), determine which words are palindromes (meaning ; may be interpreted the same way in either forward or reverse direction); ex.: "cojoc", "capac" etc.
    mov ebx,0
    mov esi, sir ; in eds:esi we will store the FAR address of the string "sir"
    mov ecx, dim_sir ; we will parse the elements of the string in a loop with dim_sir iterations
    mov byte[index],dim_sir
    cmp byte[index],0
    je Sfarsit
    loop1:
        mov dl,0
        ; jecxz check_if_palindrom
        get_the_letters:
            jecxz Sfarsit
            mov eax, 0
            lodsb ; store into al each byte from the string, convert it to dword 
            cmp al,20h ; we search for the ascii code of ' '
            je check_if_palindrom
            add dl,1h ; we keep track of the bytes we use
            push eax ; push to stack
            dec byte[index]
        loop get_the_letters
        
        check_if_palindrom:
            mov edi, sir
            mov dh,1 ; we assume that the current word is a palindrome
            cmp dl,0
            je verifica
            loop2:
                pop eax ; since the string was pushed element by element on the stack, when removing it, it will be in reverse order
                scasb ; we can compare what is on the stack with the current element pointed by edi
                je a_palindrome
                mov dh,-1 ; if the word is not a palindrome we attribute a corresponding value
                a_palindrome:
                    sub dl,1h ; we decrement dl in order to keep the loop going
            jnz loop2
            verifica:
                mov byte[rez+ebx],dh ; we move into the rez the byte that shows either the current word is a palindrome or not
                inc  ebx
    jnz loop1
    Sfarsit:
    ; exit(0)
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program