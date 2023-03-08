bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

a dd 'bK', 4219106770, 0A54ADEE6h, 100100010110100011000100111000b

b dw 1110110111001111b, 0B2A3h, 17318, 'O'

c dw 110110010000100b, 675Ch, 37589, '1Y'

d db 'P', 'w', 11000000b, 0C2h, 8Ah, 4Dh, 1101b, 129

e dq 16314AD3Ah, 4EB62301FFA3h, 2A14E5DA3DEh, 46645C3DAEBh

segment code use32 class=code
start:

mov EAX, [b + 3]
mov EBX, [a + 1]
mov ECX, [c + 4]
mov EDX, [a + 5]
RCR AX, 10
ROR CH, 10
ADC CL, [d + 2]
SHR BX, 5
SHL BX, 11
SUB CL, [d + 3]
SAL AX, 14
stc
SBB AX, [c + 3]
SAR AX, 7
ROL DL, 6
RCL CH, 12
ADD EDX, [b + 1]
clc
AND BX, [b + 4]
push dword 0
call [exit]