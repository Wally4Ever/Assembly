org 100h

jmp start

arr1 DB 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
arr2 DB 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh, 10h, 11h, 12h, 13h
arr3 DB 20 DUP (?)
arr4 DB 20 DUP (?)

start:
; move arr1 into 100h
mov si, offset arr1
mov di, offset arr2

; a) calculate in ax the value SUM(Xi*Yi)=1..10
xor ax, ax
xor dx, dx
mov cx, 10
sum:
	lodsb
	mov bl, ds:[di]
        mul bl
	add dx, ax

	inc si
	inc di

	loop sum

mov ax, dx	; store result in ax

; with a macro
prod_scal MACRO s1, s2, n
	mov si, offset s1
	mov di, offset s2
	mov cx, n

	xor ax, ax
	xor dx, dx
sum2:
	lodsb
	mov bl, ds:[di]
	mul bl
	add dx, ax

	loop sum2
mov ax, dx
prod_scal ENDM

; call macro
prod_scal arr1, arr2, 10

; b)
insert0 MACRO src, dest, n
	mov si, offset src
	mov di, offset dest
	mov cx, n

	xor ax, ax
	xor dx, dx
ins:
	lodsb
	stosb
	xor ax, ax
	stosb

	loop ins
insert0 ENDM

insert0 arr1, arr3, 10

; c)
revstr MACRO s1, s2, n
	mov si, offset s1
	mov di, offset s2
	mov cx, n
	add si, cx
	sub si, 1
repeat:
	movsb
	sub si, 2
	loop repeat

revstr ENDM

revstr arr1, arr4, 10

revstr2 PROC 
	; write proc here
revstr2 ENDP

ret
