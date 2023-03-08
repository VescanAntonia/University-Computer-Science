bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fscanf,fprintf,fread,fwrite,fopen,printf,fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fwrite msvcrt.dll
import fread msvcrt.dll
import fscanf msvcrt.dll
import fprintf msvcrt.dll  
import printf msvcrt.dll  ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    wr_mode db 'w',0
    rd_mode db 'r',0
    text db 0
    input_file db 'fisier1.txt',0
    output_file db 'fisier2.txt',0
    handle_in db -1
    sir_rezerva times 100 db 0
    len equ 100
    handle_out db -1
    read_format db "%s",0
    index db 1
    new_text times 100 db 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...SCRIETI UN PROGR CARE CITESTE DINTR UN FISIER PROPOZITII. PROPOZITIILE SUNT SIRURI DE CARACATERE CARE SE TERMINA CU CARACT . 
;SCRIETI IN ALT FISIER DOAR PROPOZITIILE DE ORDIN PAR PAR. NUMELEL CELOR DOUA FISIERE SUNT IN SEGMENTUL DE DATE
        push dword rd_mode
        push dword input_file
        call[fopen]    ;deschidem fisierul pentru citire
        add esp,4*2      ; curatam stiva
        mov [handle_in],eax
        cmp eax,0    ; verificam daca nu s-a produs o eroare in deschidere
        je finish
        
        
        push dword wr_mode
        push dword output_file
        call[fopen] ; deschidem fisierul pentru scriere
        add esp,4*2   ; curatam stiva
        mov [handle_out], eax
        cmp eax,0    ; verificam daca nu s-a produs o eroare in deschidere
        je finish
        
        ;push dword[handle_in]
        ;push dword len 
        ;push dword 1      ;citim tot textul din fisier
        ;push dword text
        ;call [fread]
        ;add esp,4*4
        
        
        my_loop:
            push dword[handle_in]
            push dword 1 
            push dword 1      ;citim textul din fisier byte cu byte
            push dword text
            call [fscanf]
            add esp,4*4
            mov al,[text] ;punem in al byteul citit
            cmp al,0   ;verificam daca nu am citit toate caracterele din fisier 
            je end_loop
            cmp byte[index],0    
            jne continue
            push dword [handle_out]
            push dword 1
            push dword 1
            push dword text
            call [fprintf]
            add esp,4*4
            cmp al,'.'
            je change_the_index 
            jmp my_loop
            change_the_index:
            mov byte[index],1
            jmp my_loop
            continue:
            mov byte[index], 0
        jmp my_loop
        end_loop:
        
        ;push dword text
        ;push dword 1
        ;push dword len
        ;push dword[handle_out]
        ;call[fwrite]
        ;add esp,4*4
      
        push dword [handle_in]   ; inchidem fisierul de input
        call [fclose]
        add esp,4
        
        push dword[handle_out]  ; inchidem fisierul de output
        call [fclose]
        add esp,4
        finish:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
