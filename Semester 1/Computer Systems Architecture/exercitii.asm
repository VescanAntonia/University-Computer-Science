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
    ;A DD 0a344dh, 30h, 11223344h, 46ab89ch
    ;a db 1,2,3,10,20,30
    ;a times 4 dd 2
   ; a db 5
    ;l equ 10
    ;b dw a+1
    ;a db '123','4','56'
    ;b resd 1
    ;c dw 4-1,3
    ;a db 9
    ;b times 2 dd 1234h
    ;c db 16h
    ;x dw 0ffffh
    ;a times 3 db 2
    ;l equ 3
    ;b dw 10
    
    a dd 1a2b3ch, 4d9fh, 6e5d27h

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;mov al,-2
        ;mov bl,-128
        ;imul bl
        ; al,-1
        ;neg al
        
        ;mov ax,[a+2]
        ;mov bx, [a+5]
       
       ;mov ecx, -1<<12
       
       ;SBB AL,AL
    
        ;XOR AL,AL
        
        ;MOV AL,-1
       ; NEG AL
       ;mov ah,-128
       ;mov bh,80h
       ;add ah,bh
       
       ;mov ax,600
       ;cwde
       ;mov cx,-2
       ;idiv cx
       ;mov ecx,-1<<12
       
       ;mov ax, -1
       ;sbb dx,dx
       ;mov eax,01101011111100000000000000000000b
       ;shr eax,1
       
       ;mov ax,5
       ;mov bh,2
       ;idiv bh
       
       ;MOV AX, 0ffffh
       ;cwd
       ;add dx,1
       ;mov bx, 65535
       ;div bx
       
       ;mov ah, 054ah
       ;add [x],2
       
       ;mov eax,  -1&-4
       ;xor al,al
       ;cbw
       ;cwd
       
       
       ;mov eax,5892h
       ;mov cl,8d
       ;shr eax,cl
       ;and eax, 00000000000000000000000000001111b
       
       
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
