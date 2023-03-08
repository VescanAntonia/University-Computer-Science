bits 32

global start 
extern exit, fopen, fclose, fread, fwrite, rename, remove, perror, sprintf, fprintf
import exit msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import rename msvcrt.dll
import fprintf msvcrt.dll
import remove msvcrt.dll
import perror msvcrt.dll ; -> perror prints a given message to which it concatenates a more detailed message based on the errno variable
; this variable is automatically set by system functions when things go sideways (as in they go wrong)
import sprintf msvcrt.dll ; -> sprintf behaves similarly to printf, however, instead of displaying a string, it writes it in a string given as a parameter
; the function signature is int sprintf(char *destination, char *template, ...)

; Write a program that reads the content of a text file (a.txt), adds 1 to each byte and then writes these bytes to a new file (b.txt) and then renames this new file to be the old file name (a.txt).
segment data use32 class=data
    text db "52*1/3*7", 0
    dim_sir equ ($-text)-1
    outfile db 'b.txt', 0
    rd_mode db 'r', 0
    wr_mode db 'w', 0
    decriptor resb 1
    output db "   Result: %d",0 
    index dd 0
segment code use32 class=code
start:
    
    
   
    mov ecx, dim_sir
    myloop:
    jecxz finish_loop
        mov eax,0
        mov al,[text+ecx-1]  
        cmp al,39h
        jg Continue
            
        cmp al,30h
        jng Continue
        
        sub al,'0'
        add [index],al
        Continue:
        
       ; dec eax
        dec ecx
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
    push output
    push dword [decriptor]
    call [fprintf]
    add esp, 4*3
    
    push dword [decriptor]
    call[fclose]
    add esp,4
    
    done:
    
    push dword 0
    call [exit]