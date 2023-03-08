bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;x dw -256, 256h
    ;y dw 256|-256, 256h&256
    ;z db $-z, y-x
     ; db 'y'-'x', 'y-x'
    ;a db 512>>2, -512<<2
    ;b dw z-a, !(z-a)
    ;c dd ($-b)+(d-$)
    ;d db -128, 128^(~128)
    ;e times 2 resw 6
      ;times 2 dd 1234h, 5678h
    SIR DD 45874589h,14587426h
    len equ ($-sir)/2
    sir times 10 dw 0
    n db 1
    nr dw -128
    c db 1
    format dw '%d',0
    ;b dw ~b
    k db 2*2
    exemplu dd -1001010110b
    lga dw $-$$
    ;format dw "%d",44,0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        test ecx,ecx
        mov eax,5
        mov cl,1
        idiv cl
        
        mov esi,SIR
        mov edi,0
        my_loop:
            lodsw
            cmp ax,0
            je done_loop
            shr ax,8
            mov bx, ax
            lodsw
            shr ax,8
            shl ax,8
            or ax,bx
            mov [sir+edi],ax
            inc ecx
            inc edi
            inc edi
        loop my_loop
        mov edi,0
        done_loop:
        push dword sir
        push dword format
        call [printf]
        add esp, 4*2
         ;   cmp ecx,0
          ;  je out
           ; mov edx, [sir+edi]
        ;    push dword edx
         ;   push dword format
          ;  call[printf]
        ;    add esp,4*2
         ;   inc edi
          ;  inc edi
           ; dec ecx
        ;loop done_loop
        out:
        ;mov ah, nr-$$
        ;mov ebx, !(sir+7)-!(sir+7)
        
        ;mov eax, [ebx*1+ecx*2]
        
        ;mov eax, 200
        ;mov ebx,254h
        ;idiv bl
        
        ;mov  ax, 256h
        ;mov dx, -1
        ;add ah,dh
                
        ;mov ax,~(16h|32)
        ;mov bx, 2000h>>4
        ;imul bh
        
        ;mov ax,21<<7
        ;mov bh, 10h^3
        ;sub bh,al
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
