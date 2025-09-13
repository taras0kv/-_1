.MODEL small
.STACK 256

.DATA
    arr DW 5, 10, -3, 7, 2
    n   DW 5
    sum DW 0
    diff DW 0
    exitCode DB 0

.CODE
START:
    mov ax, @data
    mov ds, ax

    ; --- Сума елементів масиву ---
    mov cx, [n]
    xor si, si
    xor ax, ax
sum_loop:
    mov bx, [arr + si]
    add ax, bx
    add si, 2
    loop sum_loop
    mov [sum], ax

    ; --- Різниця: arr[0] - arr[1] - arr[2] - ... ---
    mov ax, [arr]
    mov cx, [n]
    dec cx
    mov si, 2
diff_loop:
    mov bx, [arr + si]
    sub ax, bx
    add si, 2
    loop diff_loop
    mov [diff], ax

Exit:
    mov ah, 4Ch
    mov al, [exitCode]
    int 21h
END START
