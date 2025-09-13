.MODEL small
.STACK 256

.DATA
    delta DD 0.001
    divK  DD 5.0
    xr    DW 0
    yr    DW 0

.CODE
.486
start:
    mov ax, @data
    mov ds, ax

    mov cx, 0C470h        ; лічильник циклу
    mov ax, 12h           ; режим 640x480x16 VGA
    int 10h

    finit                 ; ініціалізація FPU
    fldz                  ; ST(0) = 0
    mov ah, 0Ch
    xor bx, bx

l1:
    fld st                ; копія кута
    fld st                ; ще копія
    fsincos               ; ST(0)=cos, ST(1)=sin, ST(2)=кут
    fmul divK
    fmul st, st(2)
    fistp word ptr xr

    fmul divK
    fmul
    fistp word ptr yr

    push cx
    mov cx, xr
    mov dx, yr
    add dx, 240
    add cx, 320

    mov al, 0A3h
    int 10h 

    sub dx, yr
    sub dx, yr

    mov al, 0A4h
    int 10h

    pop cx
    fadd delta
    loop l1

    mov ah, 0
    int 16h
    mov ax, 3
    int 10h

    mov ah, 4Ch
    int 21h
end start
