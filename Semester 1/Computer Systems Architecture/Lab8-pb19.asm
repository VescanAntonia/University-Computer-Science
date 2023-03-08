bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start   

; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ; index db 0
    message1  db "YES", 0  ; definining the message
    message2  db "NO", 0  ; definining the message
    msg_a db "a=", 0
    msg_b db "b=", 0
    a db  0       ; defining the variable a
    b dd  0       ; defining the variable b
	read_format  db "%d", 0  ; definining the format
    index db 8

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; Read one byte and one word from the keyboard. Print on the screen "YES" if the bits of the byte read are found consecutively among the bits of the word and "NO" otherwise. Example: a = 10 = 0000 1010b
        ; b = 256 = 0000 0001 0000 0000b
        ; The value printed on the screen will be NO.
        ; a = 10d = 0Ah = 0000 1010b
        ; b = 24913d = 6151h = 0110 0001 0101 0001b
        ; The value printed on the screen will be YES (you can find the bits on positions 5-12).
        push dword msg_a ; ! on the stack is placed the address of the string
        call [printf] ; call function printf for printing
        add esp,4*1 ; we clear the stack
        push dword a
        push dword read_format
        call [scanf]
        add esp, 4*1 ; we clear the stack
        
        push dword msg_b ; ! on the stack is placed the address of the string
        call [printf] ; call function printf for printing
        add esp,4 ; we clear the stack
        push dword b
        push dword read_format
        call [scanf] ; call function scanf for reading
        add esp, 4*2 ; we clear the stack
        
        mov al,byte[a] ; al = a
        
        mov ah,0 
        mov dx,0
        mov cl,0 
        cmp byte[index],0
        je Sfarsit_loop
        Repeta:
            mov bx,word[b] 
            shr bx,cl
            and bx,0000000011111111b
            cmp bx,ax
            jne Continua
            mov dx,1
            Continua:
                add cl,1h     
            dec byte[index]
        jnz Repeta
        Sfarsit_loop:
        cmp dx,1
        jne loop2
        loop1:
            push dword message1
            call [printf]
            add esp, 4*1
            jmp Sfarsit
        
        
        loop2:
            push dword message2
            call [printf]
            add esp, 4*1
            
        
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
