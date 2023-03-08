bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf,gets               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import scanf msvcrt.dll
import printf msvcrt.dll 
import gets msvcrt.dll  ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s2 times 100 dd 0
    a dd 0
    wr_format db "%d",44,0
    x db '%s',13,0
    read_format db "%d",0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;push dword string
        ;push dword read_format
        ;call[gets]                ;THIS READS A STRING
        ;add esp, 4*2
                                     
        ;push dword string
        ;push dword read_format
        ;call [printf]          ;THIS PRINTS A STRING
        ;add esp,4*2
        
        
        ;push dword string
        ;push dword read_format
        ;call [gets]
        ;add esp,4*2
        
        ;push dword string
        ;push dword read_format
        ;call [printf]
        ;add esp,4*2
        
        
        mov ebx,0
        citire:
            push dword a
            push dword read_format
            call [scanf]
            add esp, 4*2 ; we clear the stack
            cmp dword[a],0
            je done_loop
            mov edx,[a]
            mov dword[s2+ebx],edx
            add ebx,4
        loop citire
        done_loop:
        mov esi,s2
        mov edi,0
        print:
            mov edx,[s2+edi]
            push dword edx
            cmp edx,0
            je done
            push wr_format
            call [printf]
            add esp,4*2
            add edi,4h
        jmp print
        done:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
