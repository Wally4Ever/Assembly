org 100h
jmp start:
;Write the program to read from the keyboard 3 numbers, 
;(a, b, c), each of exactly 2 digits and to calculate and 
;display on the screen the result of their sum.org 100h 
mesaj   DB 'Introduceti 3 numere de exact 2 cifre separate de +: ', '$';
errmsg  DB 'Try again! Wrong input!', '$';
n1bin   DB	    0
n2bin   DB      0
n3bin   DB      0
suma    DB      3 DUP(?)

start: 
    mov dx, offset mesaj;  
    mov ah, 09h;
    int 21h; 
    
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt    
    mov dh, al;      
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt
    mov dl, al;
    
    call convab		; convert ASCII-BINARY
    ; BL contains the 2nd number in binary
	mov	[n1bin],bl                   
	
	mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt
    cmp al, '+';      verify if 3rd char is +
    jnz error
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt    
    mov dh, al;      
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt
    mov dl, al;
    
    call convab		; convert ASCII-BINARY
    ; BL contains the 2nd number in binary
	mov	[n2bin],bl
	
	mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt
    cmp al, '+';      verify if 3rd char is +
    jnz error
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt    
    mov dh, al;      
    
    mov ah, 01h;     ;kb to screen
    INT 21h;         ;kb interrupt
    mov dl, al;
    
    call convab		; convert ASCII-BINARY
    ; BL contains the 3rd number in binary -> check if actually number
       
    
    xor ax, ax;
    mov al, [n1bin];
    add al,bl;        1st + 3rd number
    mov bl, [n2bin];
    add al, bl;
	call    convba		;convert the number from AL into ASCII
	call	disprez		;display result
	
	 
	jmp gata;
	 
error:
    mov dx, offset errmsg;  
    mov ah, 09h;
    int 21h; 
gata:
    ret 
        
;ASCII TO BIN     
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

;BIN TO ASCII
convba	PROC	NEAR
	xor	ah,ah	;     AH=0 , AL = the number
	mov	cl,10
	div	cl	; 
	add ah,30h	;     decimal--->ASCII
	mov	[suma+2],ah	; units digit
;
	xor	ah,ah
	div	cl
	add	ah,30h
	mov	[suma+1],ah	; tens digit
;
	add	al,30h
	mov	[suma],al	; hundreds digit
;
	ret
convba	ENDP      

disprez	PROC	NEAR
	mov	bh,0
	mov	dx,11*256+1    ; set cursor location
	   
	mov	ah,0eh	;        teletype mode
	mov	al,'='
	int	10h
	       
	mov al,[suma]
	cmp	al,'0'
	jz	nosute
	int	10h            ; daca rezultat <100 sari peste cifra sutelor
nosute:
    mov	al,[suma+1]
	int 10h            ;cifra zeci
	mov	al,[suma+2]
	int	10h		       ;cifra unitati
	ret
;
disprez ENDP