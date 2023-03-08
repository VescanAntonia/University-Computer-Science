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
    a dw 12300
    b db 9
    c db 3
    e dd 2200
    x dq 30000000

; our code starts here
segment code use32 class=code
    start:
        ; ... 
        ; signed representation
        ; a*b-(100-c)/(b*b)+e+x; a-word; b,c-byte; e-doubleword; x-qword
      
       mov al,[b]
       cbw
       imul byte[b]
       mov bx,ax
       push dx
       push ax
       pop ecx 
       mov al, 100
       cbw
       sub al, byte[c]
       cwd   
       idiv bx
       push dx
       push ax
       pop ecx ; ecx=(100-c)/(b*b)
       mov al, [b]
       cbw
       imul word[a]
       cwd
       push dx
       push ax
       pop eax ; eax=a*b
       sub eax, ecx
       mov ebx, [e]
       add eax, ebx
       cdq
       add eax, dword[x+0]
       adc edx, dword[x+4] ; edx:eax = a*b-(100-c)/(b*b)+e+x
       clc
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
