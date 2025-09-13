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
    finit             ; ініціалізація FPU
    xor si, si
    fldz              ; ST(0) = 0.0 — початкова сума

loop_fpu:
    fld DWORD PTR [X + si]   ; завантажити X[i]
    fld DWORD PTR [Y + si]   ; завантажити Y[i]
    fmulp st(1), st(0)       ; X*Y
    faddp st(1), st(0)       ; додати до суми
    add si, 4                ; REAL4 = 4 байти
    loop loop_fpu

    fstp DWORD PTR [SUM]     ; записати результат у SUM

Exit:
    mov ah, 4Ch
    mov al, [exitCode]
    int 21h
END START
