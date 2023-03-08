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
    a db 5
    b db 3
    d db 2 

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;[(a+b)*2]/(a+d)
        ; a,b,c,d-byte, e,f,g,h-word
        mov al, [a] ; al=a
        add al, [b] ; al=a+b 
        mov ah,2 ; ah=2
        mul ah ; ax=al*ah=(a+b)*2
        mov cl, [a] ; cl=a 
        add cl, [d] ; cl=cl+d=a+d 
        div cl ; al=al/cl=[(a+b)*2]/(a+d)
  
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
