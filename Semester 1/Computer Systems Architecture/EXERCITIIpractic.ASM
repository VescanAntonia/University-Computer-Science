bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fclose,fread,printf,fwrite,rename,remove,fprintf, sprintf, perror               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import rename msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import remove msvcrt.dll
import sprintf msvcrt.dll
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
    format_letter dd '%s',0
    handle_out dd -1
    wr_mode db 'w',0
    b db 0
    file_err_tmplt db "error encountered at file %s",0
    rd_mode db 'r',0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword rd_mode  ; we open the input file
        push dword input_file
        call [fopen]
        add esp,4*2
        mov [handle_in],eax
        cmp eax,0
        je error_file_a
        
        push dword wr_mode  ; open the output file
        push dword file_for_output
        call [fopen]
        add esp, 4*2
        mov [handle_out], eax
        cmp eax,0
        je error_file_b
        
        my_loop:
            push dword [handle_in]
            push dword 1
            push dword 1
            push dword b
            call [fread]
            add esp, 4*4
            cmp eax,0
            je close
            cmp dword[b],'z'
            jnb continue
            cmp dword[b],'a'
            jb continue
            push dword[handle_out]
            push dword 1
            push dword 1
            push dword b
            push dword format_ascii
            call [fwrite]
            add esp,4*5 
            jmp my_loop
            continue:
            push dword[handle_out]
            push dword 1
            push dword 1
            push dword b
            add esp,4*4
            
         jmp my_loop
            
        
        close:
        push dword [handle_in]
        call [fclose]
        add esp,4
        
        push dword [handle_out]
        call [fclose]
        add esp,4
        
        push dword input_file
        call [remove]
        add esp,4
        
        push dword input_file 
        push dword file_for_output
        call [rename]
        add esp,4*2
        jmp done
        
        error_file_b:
            push file_for_output
            push file_err_tmplt
            push err
            call [sprintf]
            add esp,4*3
            
            push dword err
            call [perror]
            add esp,4*1
            jmp done
        
        error_file_a:
            push input_file
            push file_err_tmplt
            push err
            call [sprintf]
            add esp,4*3
            
            push dword err
            call [perror]
            add esp,4*1
            jmp done
        
        done:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
