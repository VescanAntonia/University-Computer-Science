bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start 

; declare extern functions used by the programme
extern exit, fopen, fclose, fread, fwrite, rename, remove, perror, sprintf, fprintf
import exit msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import rename msvcrt.dll
import fprintf msvcrt.dll
import remove msvcrt.dll
import sprintf msvcrt.dll
import perror msvcrt.dll 
segment data use32 class=data
    text db "52*123/3*7", 0
    dim_sir equ ($-text)-1
    outfile db 'fisier.txt', 0
    rd_mode db 'r', 0
    wr_mode db 'w', 0
    decriptor resb 1
    output_format db "Result: %d", 0 
    index dd 0
segment code use32 class=code
start:
    
    ;A file name and a text (which can contain any type of character) are given in data segment. Calculate the sum of digits in the text. Create a ;file with the given name and write the result to file.
    
    mov esi, text
    mov ecx, dim_sir
    myloop:
    jecxz finish_loop
        mov eax,0
        lodsb  
        cmp al,39h
        jg Continue
            
        cmp al,30h
        jng Continue
        
        sub al,'0'
        add [index],al
        Continue:
        
    loop myloop
        
        
    finish_loop:
    push wr_mode
    push outfile
    call [fopen]
    add esp, 4*2
    
    mov [decriptor], eax
    cmp eax,0
    je done
    
    push dword[index]
    push output_format
    push dword [decriptor]
    call [fprintf]
    add esp, 4*3
    
    push dword [decriptor]
    call[fclose]
    add esp,4
    
    done:
    
    push dword 0
    call [exit]