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
    a dw 9
    b db 5
    c db 3
    e dd 12
    x dq 121

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Unsigned representation 
       ; a*b-(100-c)/(b*b)+e+x; a-word; b,c-byte; e-doubleword; x-qword
       
       mov al,0
       mov ah, 0
       mov ax,[b]
       mul byte[b] ;ax=b*b
       mov bx,ax ; bx=ax=b*b
       push dx
       push ax
       pop eax 
       mov ah, 0
       mov al, 100
       sub al, [c] ; al=100-c
       mov dx, 0
       div bx ; ax=ax/bx=(100-c)/(b*b)
       push dx
       push ax
       pop eax ; eax=(100-c)/(b*b)
       
       mov cx, word[a]
       mul byte[b]
       sub cx,bx
       push dx
       push ax
       pop eax ; eax=a*b-(100-c)/(b*b)
       mov ebx, [e]
       add eax, ebx
       add eax, dword[x+0]
       adc edx, dword[x+4] ; edx:eax = a*b-(100-c)/(b*b)+e+x
      
      
       
       
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
