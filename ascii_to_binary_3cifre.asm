org 100h

jmp start

AsciiCodr DB 311
Binary DW ?

start:
mov si, offset AsciiCode	; set si at table beginning
mov bl, [si + 2]	; 3rd char in bl
sub bl, 30h		; subtract ascii code offset
mov al, [si]		; move first char in al
sub al, 30h		; subtract ascii code offset
mov cl, 10		; set tens
mul cl			; multiply to get tens
add bl, al		; get full number from tens + units
mov al, [si]
sub al, 30h
mov cl, 100		; get hundreds
mul cl
add ax, bx		; hundreds + tens + units
mov [Binary], ax	; set Binary number

ret
