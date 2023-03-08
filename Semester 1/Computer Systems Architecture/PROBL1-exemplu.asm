bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,printf,fread,fwrite,rename,remove,fprintf, sprintf, perror               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import rename msvcrt.dll
import fprintf msvcrt.dll
import remove msvcrt.dll
import sprintf msvcrt.dll
import printf msvcrt.dll
import perror msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    input_file db 'x.txt',0
    file_for_output db 'y.txt',0
    decriptor resb 0
    handle_in dd -1
    err times 255 db 0
    format_ascii dd '%d',0
    format_letter dd '%c',0
    handle_out dd -1
    output_format db "result: %s",0
    wr_mode db 'w',0
    b db 0
    print_format db '%s',0
    len equ 100
    text times len db 0
    file_err_tmplt db "error encountered at file %s",0
    rd_mode db 'r',0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword rd_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [handle_in], eax
        cmp eax,0
        je error_A
        
        push dword [handle_in]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        push dword text
        push dword print_format
        call [printf]
        add esp,4*2
        
        push dword wr_mode
        push dword file_for_output
        call [fopen]
        add esp, 4*2
        mov [handle_out], eax
        push dword text
        push dword 1
        push dword len
        ;push dword output_format
        push dword [handle_out]
        call [printf]
        add esp,4*4
        push dword [handle_out]
        call [fclose]
        add esp,4
        
        
        cld 
        mov ecx,2
        mov esi,text
        
        my_loop:
            lodsb
            cmp al,'a'
            jnb print_ascii
            cmp al,0
            je error_A
            print_letter:
                push dword eax
                push dword format_letter
                call [printf]
                add esp,4*2
            jmp endloop
            print_ascii:
                push dword eax
                push dword format_ascii
                call [printf]
                add esp,4*2
            endloop:
            mov ecx,2
         loop my_loop
      
    
        error_A:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
