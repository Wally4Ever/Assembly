#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

; al = max(al,bl,cl)

; prepare variables
mov al, 13
mov bl, 93
mov cl, 15

cmp al, bl	; compare al with bl
jg  al_greater	; if al is greater, jump to label
cmp bl, cl	; else, compare bl with cl
jg  bl_greater	; if bl is greater, jump to label
mov al, cl	; else, cl is the max, so move it to al

al_greater:
	ret	; nothing to be done, already max
	
bl_greater:
	mov al, bl	; bl is max, so move it to al
	
ret
