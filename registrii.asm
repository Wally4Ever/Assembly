#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

mov ax, 0B000h
mov ds, ax	; set DS addr
mov si, 1	; set si offset
mov di, 2	; set di offset
mov [si], 13	; set value for si
mov ds:[di], 17	; set value for di

xor ax, ax	; clear ax
add al, [si]	; ax = ax + [si]
add al, ds:[di]	; ax = ax + ds:[di]
mov si, ax	; set si at index sum
mov [si], si	; move sum at index sum

ret