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
import perror msvcrt.dll ; -> perror prints a given message to which it concatenates a more detailed message based on the errno variable
; this variable is automatically set by system functions when things go sideways (as in they go wrong)
import sprintf msvcrt.dll ; -> sprintf behaves similarly to printf, however, instead of displaying a string, it writes it in a string given as a parameter
; the function signature is int sprintf(char *destination, char *template, ...)

; Write a program that reads the content of a text file (a.txt), adds 1 to each byte and then writes these bytes to a new file (b.txt) and then renames this new file to be the old file name (a.txt).
segment data use32 class=data
    infile db 'a.txt', 0
    outfile db 'b.txt', 0
    rd_mode db 'r', 0
    wr_mode db 'w', 0
    b db 0
    text db "abcd%tsg/aacfcfacfa$#%",0
    handle_in dd -1
    decriptor resb 1
    handle_out dd -1
    output db "%d",0
    err times 255 db 0 ; make space for a 255 character long string so we can put a custom err message
    file_err_tmplt db "Error encountered at file %s", 0 
    rename_err_tmplt db "Error when renaming %s to %s", 0 
    index db 0
segment code use32 class=code
start:
    ; fopen(char *path, char *mode)
    ; open first file in read mode
    push dword rd_mode
    push dword infile
    len equ 100
    call [fopen]
    add esp, 4 * 2
    mov [handle_in], eax
    cmp eax, 0
    je done
    
    push dword [handle_in] ; file handle
    push dword len ; count -> how many times to try to read chunks of size "size"
    push dword 1 ; size -> size of the chunks that will be read
    push dword text ; address of the buffer where to store what is being read
    call [fread]
    add esp, 4 * 15
   
    mov ecx, eax
    cmp eax,0
    je close
    myloop:
        mov dl,[text+ecx-1]  
        cmp dl,39h
        jg Continue
            
        cmp dl,30h
        jng Continue
        
        sub dl,'0'
        add [index],dl
        Continue:
        
        dec eax
        dec ecx
        cmp eax, 0 
        je close
    jmp myloop
        
    close:
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