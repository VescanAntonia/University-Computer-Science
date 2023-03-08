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
    s db '1', '4', '2', '4', '8', '2', '1', '1' ; declare the string of bytes
    l equ $-s ; compute the length of the string in l
    d times l db 0 ; reserve l bytes for the destination string and initialize it
    index db 10
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; A byte string S is given. Obtain in the string D the set of the elements of S.
        ; S: 1, 4, 2, 4, 8, 2, 1, 1
        ; D: 1, 4, 2, 8
        
        mov dl,30h 
        mov esi,0
        cmp byte[index],0
        je Sfarsit
        Repeta:
            mov ecx, l ; we put the length l in ECX in order to make the second loop
            jecxz Sfarsit
            mov ebx,0
            repeta2:
                
                mov al,[s+ebx]
                cmp al,dl
                jne adaugare
                    mov [d+esi],al
                    inc esi
                    add dl,1h
                    inc ebx
                adaugare:
                inc ebx
              
            loop repeta2
            add dl,1h
            dec byte[index]
        jnz Repeta
        Sfarsit:;end of the program
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
