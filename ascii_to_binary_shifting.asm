#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

mov dl, 1Ah	; unsigned value in DL
mov si, 100h	; set offset to 100h

mov al, dl	; copy to al
and al, 0F0h	; leave only tens
mov cl, 4
shr al, cl	; shift to right digit

mov ah, al	; set tens in ah
add ah, 30h	; add ascii code for 0

mov al, dl	; copy again to al
and al, 0Fh	; leave only units
add al, 30h	; add ascii code for 0

mov [si], ax	; set number in DS:[100h]

ret