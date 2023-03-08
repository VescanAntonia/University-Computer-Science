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
    a dd 01110111010101111101110010011100b
    b dw 1001101110111110b
    c dw 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Given the doubleword A and the word B, compute the word C as follows:
            ;the bits 0-4 of C are the invert of the bits 20-24 of A
            ;the bits 5-8 of C have the value 1
            ;the bits 9-12 of C are the same as the bits 12-15 of B
            ;the bits 13-15 of C are the same as the bits 7-9 of A 
            
        mov  bx, 0 ; we compute the result in bx
        
        mov eax, dword[a]
        not eax ; we invert the value of a
        and eax,00000001111100000000000000000000b ; we isolate bits 20-24 of a
        mov cl, 20 ; cl=20
        ror eax, cl ; we rotate 20 positions to the right
        or bx,ax ; we put the bits into the result
        
        or bx, 0000000111100000b ; we force the value of bits 5-8 of the result to the value 1
        
        mov ax,[b] 
        and  ax, 1111000000000000b ; we isolate bits 12-15 of b
        mov cl, 3
        ror ax,cl ; we rotate 3 positions to the right
        or bx,ax ; we put the bits into the result
        
        mov eax, dword[a]
        and eax, 00000000000000000000001110000000b ; we isolate bits 7-9 of a
        mov cl, 6
        rol ax,cl ; we rotate 6 positions to the left
        or bx,ax ;  we put the bits into the result
        
        mov [c], bx ; we move the result from the register to the result variable
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        