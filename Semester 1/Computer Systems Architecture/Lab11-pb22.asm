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
extern calculate_the_new_string
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;message db "Nr",0
    string dd 415,4785,15423
    new_string db 0
    ;read_format db "%s",0
    a dd 0
    read_format  dd "%d", 0
    index db 0
    s1 times 100 dd 0
    s2 times 100 dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...Read a string of integers s1 (represented on doublewords) in base 10. Determine and display the string s2 composed by the ;digits in the hundreds place of each integer in the string s1.
        ; Example:    The string s1: 5892, 456, 33, 7, 245
        ; The string s2: 8,    4,   0,  0, 2
    
        ;push dword message
        ;call [printf]
        ;add esp, 4*1
        ;push dword string
        ;push dword read_format
        ;call[scanf]
        ;add esp, 4*1
        
        ;mov eax, dword[string]
        mov ebx,0
        citire:
        ;push dword message ; ! on the stack is placed the address of the string
            ;call [printf] ; call function printf for printing
            ;add esp,4*1 ; we clear the stack
            push dword a
            push dword read_format
            call [scanf]
            add esp, 4*1 ; we clear the stack
            cmp dword[a],0
            je calculate
            add ebx,1
            mov dword[s1+ebx],a
        loop citire
            
        calculate:
        push dword[s1]
        push s2
        call calculate_the_new_string
        
        ;mov esi, string
        ;loop:
         ;   lodsw
          ;  cmp al,0
           ; je done_loop
            ;mov cl,8d
            ;shr eax,cl
            ;and eax, 00000000000000000000000000001111b
            ;mov dword[new_string+index], eax
            ;inc byte[index]
            ;mov dword[new_string+index], ','
        ;jmp loop
        
       
        done_loop:
        push dword s1
        call [printf]
        add esp,4*3
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
