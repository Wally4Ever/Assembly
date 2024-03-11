PAGE 60,132
TITLE ROTIT
COMMENT * *

STIVA	SEGMENT		PARA	STACK	'STACK'
	DW		256	DUP(?)
STIVA	ENDS
;
DATA	SEGMENT		PARA	PUBLIC	'DATE'
text	DB		'HAPPY_NEW_YEAR!!!',0
lung	equ		$-text-1
contor	db		0
DATA	ENDS
;
; Segment de cod
;-----------------
;
CODE	SEGMENT		PARA	PUBLIC	'COD'

MAIN	PROC		FAR
	ASSUME		SS:STIVA,DS:DATA,CS:CODE,ES:NOTHING

	push	ds
	xor	ax,ax
	push	ax		; prepare for RET
	mov	ax,DATA
	mov	ds,ax		; prepare DS
;;;;;;


	mov	al,es:[82h]     ; get the first argument in the command line
	sub	al,'0'		; convert the number from ASCII TO BINARY
	mov	[contor],al	; set the value of the 'contor' variable

	mov	bh,0
capat:
 	mov	dx,0*256+40-lung	; cursor position
plimba:
	mov	bl,1fh	        ; 
	call 	scrtext
	call	delay		;stall
	sub	dl,lung         ; subtract from DL the length of the 'text' variable
	call	strtext
	sub 	dl,lung
  	inc dh
        cmp dh,25
	jb	plimba
	mov	al,[contor]
	dec	al
	mov	[contor],al
	cmp	al,0
	jnz	capat
	ret
MAIN	ENDP

; Procedures
;----------------
; 
strtext	PROC	NEAR
	mov	bl,0   ; video page
	call	scrtext
	ret
strtext	ENDP


; 
scrtext	PROC	NEAR
	mov	cx,1
	mov	si,offset text ; get the offset of the text variable
iar:
	mov	ah,2  ; set the cursor position for int 10h (dh row dl column)
	int	10h
	lodsb         ; load the next character from the text variable
	cmp	al,0  ; see if you reached the end
	jz	endtext
	mov	ah,9   ; prepare the display mode for int 10h
	int	10h
	inc	dl     ; increment cursor position
	jmp	iar
endtext:
	ret
scrtext	ENDP



; Delay procedure		
delay	PROC	NEAR
	push	cx
	mov	cx,0fh
pierde:
	nop
	loop	pierde
	pop 	cx
	ret
delay	ENDP




CODE	ENDS
END	MAIN

	

