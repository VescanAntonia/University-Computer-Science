bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,gets,fclose,fread,printf,fwrite,rename,remove,fprintf, sprintf, perror, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import rename msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import remove msvcrt.dll
import sprintf msvcrt.dll
import perror msvcrt.dll 
import gets msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    caracter db 0
    len equ 100
    text times len db 0
    read_format db '%s',0
    read_character db '%c',0
    msg_c db "c=",0
    msg_file db "file=",0
    output_file db "file_output.txt"
    rd_mode db 'r',0
    wr_mode db 'w',
    print_format db '%s',0
    decriptor db -1
    handle_in db -1
    output_format db '%s',0
    output_decriptor db -1
    file_err_tmplt db "error encountered at file %s",0
    input_file db 0
    index db 0
    err times 255 db 0
    sir times 100 db 0
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword msg_c
        call [printf]
        add esp,4
        push dword read_character   ; citim caracterul
        push dword caracter
        call [gets]
        add esp,4*2
        
        push dword msg_file
        call [printf]
        add esp, 4*1
        push dword read_format   ; citim fileul
        push dword input_file
        call [gets]
        add esp,4*2
         
        push dword rd_mode
        push dword input_file
        call [fopen]   ; deschis fisierul
        add esp,4*2
        mov [handle_in],eax
        cmp eax, 0
        je error_a
        
        push dword[handle_in]
        push dword len
        push dword 1   ; citim din fisier
        push dword text 
        call [fread]
        add esp, 4*4
        
        ;push dword text
        ;push dword print_format
        ;call [printf]
        ;add esp, 4*2
        
        ;push  wr_mode
        ;push output_file
        ;call [fopen]
        ;add esp,4*2
        ;mov [output_decriptor], eax
        ;mp eax,0
        ;je error_b
        
        ;push dword[output_decriptor]
        ;push dword 1
        ;push dword len
        ;push dword text
        ;call [fwrite]
        ;add esp,4*4
        ;jmp done
        mov esi,text
        mov edi,0
        mov edx,0
        my_loop:
            mov al,[text+edi]
            cmp al,0
            je done
            cmp al, ','
            je check_word
            cmp al,[caracter]
            jne add_to_word
            mov byte[index],1
            add_to_word:
                mov [sir+edx], al
                add edx,1
                
            check_word:
                mov edx,0
                cmp byte[index],1
                je print_to_file
                mov byte[index],0
                mov byte[sir],0
            print_to_file:
                mov byte[index],0
                push dword sir
                push read_format
                push dword[output_decriptor]
                call [fprintf]
                add esp,4*2
                mov byte[sir],0
            
            add edi,1
            jmp my_loop
        
        jmp done
        error_b:
            push output_file
            push file_err_tmplt
            push err
            call [sprintf]
            add esp,4*3
            
            push dword err
            call [perror]
            add esp,4*1
            jmp done
        
        
        error_a:
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
            push dword[handle_in]
            call [fclose]
            add esp,4
            
            push dword[output_decriptor]
            call [fclose]
            add esp,4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
