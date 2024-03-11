#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

jmp start

AsciiCode	DW 3331h	; number 31 in ascii
Binary		DB ?

start:
mov si, offset AsciiCode	; set SI at given word

mov ax, [si]	; set word in bx
sub al, 30h	; get units
sub ah, 30h	; get tens

mov bl, al	; temp move
mov al, ah	; mov ah to al
mov ah, 0	; set ah to 0

mov cl, 10
mul cl		; ax = ax * 10, to get tens

add ax, bx	; add units to tens to get number

mov si, offset Binary	; move si to offset Binary
mov [si], al		; store result in Binary

ret
