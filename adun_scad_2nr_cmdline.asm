STIVA	SEGMENT		PARA	STACK	'STACK'
	DW		256	DUP(?)
STIVA	ENDS
;
DATA	SEGMENT		PARA	PUBLIC	'DATE'
n1bin   DB	    0
n2bin   DB      0
sumasc  DB      3 DUP(?)
errmsg  DB      'Try again! Err lin com',0
numneg  DB      0
DATA	ENDS
;
; Code segment
;-----------------
;
CODE	SEGMENT		PARA	PUBLIC	'COD'

MAIN	PROC		FAR
	ASSUME		SS:STIVA,DS:DATA,CS:CODE,ES:NOTHING

	push	ds
	xor	ax,ax
	push	ax		;preg.pt.ret
;
	mov	ax,DATA
	mov	ds,ax		;preg. DS
	call	verify
	cmp	ax,0
	jz	ok
	ret
;get the first number in the command line from PSP
ok:	mov	dh,es:[82h]
	mov	dl,es:[83h]	; DX contains the two bytes
                                ; from the PSP in ASCII 
	call	convab		; convert ASCII-BINARY
                                ; BL contains the first number in binary
	mov	[n1bin],bl	; store the first number
;get the second number in the command line from PSP
	mov	dh,es:[85h]
	mov	dl,es:[86h]	;DX contains the second number in ASCII
	call    convab  ;converted nr in bl
	mov	[n2bin],bl	;store the second number
;add the two numbers
	xor 	ah,ah
	mov     al,[n1bin]
	cmp     es:[84h], '+'
	jnz subtraction
	add al,bl		;al<--[n1bin]+[n2bin]
	jmp convdisp
	
subtraction:
    cmp al, bl 
    jg  noswap
    xchg al, bl
    mov [numneg], 1
noswap:
    sub al, bl
    jmp convdisp
convdisp:
;prepare for display	
    call    convba		;convert the number from AL into ASCII
                   		;
	call	disprez		;display result
	ret
MAIN	ENDP

; Procedures
;----------------
;Check if the command line is correct
;
VERIFY	PROC	NEAR
	mov	al, es:[80h] ;nr of params in command line: _ nr1 _ + _ nr 2  adica 6 param
	cmp al, 6
	jnz	traterr
	mov	al, es:[81h]
	cmp	al, ' '
	jnz	traterr
	mov	ax, es:[82h]
	and	ax, 0f0f0h
	cmp	ax, 3030h
	jnz	traterr
	mov	al, es:[84h]   ;unde ii + sau -
	cmp al, '+'
	jz  continue
	cmp al, '-'
	jnz traterr

continue:
	mov	ax, es:[85h]
	and	ax, 0f0f0h     ;se stocheaza 3cifra 3 cifra. cu and transf cifra in 0
	cmp ax, 3030h      ;verif daca intr-adevar in ax era un numar de max 2 cifre sau nu
	jnz	traterr
	mov ax,0
	ret
traterr:
	mov si, offset errmsg
	mov bh, 0
	mov bl, 0
	mov	ah, 0eh
iar:
    lodsb
	cmp	al, 0
	jz	stop
	int	10h
	jmp	iar
stop:
    mov	ax, 0ffffh
	ret
VERIFY  ENDP

;convert from ASCII to binary
convab	PROC	NEAR
	xor 	ah,ah
	mov 	cl,10
	and 	dx,0f0fh	;store the significant digits
	mov 	al,dh
	mul 	cl
	mov 	bl,al	; tens are stored in BL
	add 	bl,dl	; move to BL the binary number
	ret             ;bl is returned
convab	ENDP
;
;convert from binary to ASCII
;
convba	PROC	NEAR
	xor	ah,ah	;AH=0 , AL = the number
	mov	cl,10
	div	cl	; 
	add 	ah,30h	;decimal--->ASCII
	mov	[sumasc+2],ah	; units digit
;
	xor	ah,ah
	div	cl
	add	ah,30h
	mov	[sumasc+1],ah	; tens digit
;
	add	al,30h
	mov	[sumasc],al	; hundreds digit
;
	ret
convba	ENDP
;		
;display the result
;
disprez	PROC	NEAR
	mov	bh,0
	mov	dx,11*256+1
	mov	ah,0eh	;teletype mode
			;
	mov	al,es:[82h]
	int	10h
	mov 	al,es:[83h]
	int 	10h		;display the first number
	mov 	al,es:[84h]
	int	10h ; display operation

	mov 	al,es:[85h]
	int	10h
	mov	al,es:[86h]	;display the second number
	int	10h
	mov	al,'='
	int	10h
	    
	mov al, [numneg]
	cmp al, 0
	jz positive; check whether we have a negative number
	mov al, '-'
	int 10h

positive:   
	mov al,[sumasc]
	cmp	al,'0'
	jz	nosute
	int	10h
nosute:
    mov	al,[sumasc+1]
	cmp al, '0'
	jz  nozeci
	int 10h
nozeci:
	mov	al,[sumasc+2]
	int	10h		;display the sum
	ret
;
disprez ENDP
;
CODE	ENDS
	END	MAIN
  