.MODEL small
.STACK 256

.DATA
    X   DD 1.0, 2.0, 3.0, 4.0
    Y   DD 2.0, 4.0, 6.0, 8.0
    N   DW 4
    SUM DD 0.0
    exitCode DB 0

.CODE
START:
    mov ax, @data
    mov ds, ax

    mov cx, [N]
    finit             
    xor si, si
    fldz              

loop_fpu:
    fld DWORD PTR [X + si]   
    fld DWORD PTR [Y + si]   
    fmulp st(1), st(0)       
    faddp st(1), st(0)       
    add si, 4                
    loop loop_fpu

    fstp DWORD PTR [SUM]     

Exit:
    mov ah, 4Ch
    mov al, [exitCode]
    int 21h
END START
