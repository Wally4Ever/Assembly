org 100h

; ax = 6 * al - 7 * bl

; set variables
mov al, 3
mov bl, 4
mov cl, 6	; factor of al
mul cl		; ax = 6 * al

mov dx, ax	; save val for later  
mov al, 7	; factor of bl
mul bl		; ax = 7 * bl
sub dx, ax	; perform subtraction
mov ax, dx	; save result in ax

ret
