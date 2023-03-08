bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   
import printf msvcrt.dll
import scanf msvcrt.dll
 ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a1 db '256'
    a2 dw  256, 256h
    ;a3 dw $+a2
    a3 equ -256/4
    a5 db 256>>1, 256<<1
    a6 dw a5-a2, !(a5-a2)
    ;a7 dw ~a2
    a8 dd 256h^256, 256256h
    a9 dd $-a9
    a10 db 256, -255
    a11 dw 256h-256
    a12 dw 256-256h
    a13 dw -256
    a14 dw -256h
    a15 db 2,5,6,25,6,2,56
    format db "%x", 0
    N dd 0
    x dd 0
    index db 0
    message dw "insert the n:",0
    sir times 100 dd 0
    print_f dd "%x",44,0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;mov ah,129
        ;mov bh, 9Fh
        ;add ah,bh
        
        ;MOV AX,256
        ;MOV BX,-1
        ;ADD AH,BH
        
        ;MOV AH,128|2
        ;MOV BH,90H>>3
        ;SUB AH,BH
        
        ;MOV AH,0BCH
        ;MOV AL,0DEH
        ;ADD AH,AL
        
        ;MOV AX,1001H
        ;MOV BX,1111H
        ;IMUL BL
        
        MOV DH, 62H
        MOV CH,200
        SUB DH,CH
        
        ;mov ax,128
        ;ar al,7
        ;imul ah
        ;MOV AX,1000H
        ;MOV BL, 1000B+10B
        ;DIV BL
        
        ;MOV AH,0BCH
        ;MOV AL, 0DEH
        ;ADD AH,AL
        
        ;MOV AX,1001H
        ;MOV BX,1111B
        ;IMUL BL
        
        ;MOV DH,62H
        ;MOV CH, 200
        ;SUB DH,CH
        
        ;mov eax,0
        ;MOV AL, [EBX]
        
        
        
        ;push dword message
        ;call [printf]
        ;add esp,4*1
        ;push dword N
 ;       push dword format
  ;      call [scanf]
   ;     add esp,4*2
    ;    mov ecx, [N]
     ;   mov ecx, 5
      ;  mov edi,0
       ; my_loop:
        ;    cmp ecx,0
         ;   je out_loop
          ;  push dword x
           ; push dword format
            ;call[scanf]
 ;           add esp,4*2
  ;          mov dl,[x]
   ;         mov dh,0
    ;        mov ;d;word[sir+edi],edx
    ;        inc edi
    ;        inc byte[index]
     ;       dec ecx
      ;  loop my_loop
       ; out_loop:
        ;mov ecx, [index]
     ;   mov edi,0
      ;  my_second:
       ;     cmp ecx,0
        ;    je out_second
         ;   dec ecx
          ;  mov edx, [sir+edi]
           ; push print_f
    ;        push edx
     ;       call [printf]
      ;      add esp,4*2
            
            
        
     ;   out_second:
        
        ;mov ah,129
        ;mov bh, 9Fh
        ;add ah,bh
        
        ;mov ax,128
        ;sar al,7
        ;imul ah
        
        ;mov ax,256
        ;mov bx,-1
        ;add ah,bh
        
        ;mov ah,128|2
        ;mov bh,90h>>3
        ;sub ah,bh
        
        
        ;mov eax,145h
        ;shr eax,4
        ;and eax,1111b
        ;test eax,1
        ;jz yes
        ;mov bh,5
        ;yes:
        ;mov bh,al
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
