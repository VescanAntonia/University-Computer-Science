bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, printf, fread, fwrite, fprintf,remove,rename                ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import fwrite msvcrt.dll
import fread msvcrt.dll
import rename msvcrt.dll
import remove msvcrt.dll
import fprintf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sum db 0
    n db 5
    handle_in db -1
    handle_out db -1
    rd_mode db 'r',0
    print_format db 'result is : %d',0
    wr_mode db 'w',0
    input_file db 'x.txt',0
    output_file db 'y.txt',0
    b db 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword rd_mode
        push dword input_file
        call [fopen]
        add esp,4*2
        mov [handle_in],eax
        cmp eax,0
        je done
        
        mov edi,0
        my_loop:
            push dword[handle_in]
            push dword 1
            push dword 1
            push dword b
            call [fread]
            add esp, 4*4
            mov al,[b]
            cmp byte[b],0
            je done_my_loop
            
            cmp byte[b],'0'
            jb continue
            
            cmp byte[b],'9'
            ja continue
            sub al,'0'
            add [sum], al
            
            continue:
        
        done_my_loop:
        
        push dword wr_mode
        push dword output_file
        call[fopen]
        add esp,4*2
        mov [handle_out], eax
        cmp eax,0
        je done
        push dword [n]
        push dword[handle_out]
        call [fprintf]
        add esp,4*2
        
        close:
        push dword[handle_in]
        call[fclose]
        add esp,4
        
        push dword[handle_out]
        call [fclose]
        add esp,4
        done:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
