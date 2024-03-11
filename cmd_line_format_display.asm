org 100h
jmp start;
text DB "The parameters in the command line are: $"  
lung	equ		$-text-1
       
start: 

mov bl, 1fh;            mod afisare
mov bh, 0;              mod afisare

mov	dx,0*256+40-lung ;  poitie initiala cursor
mov	cx,1             ;  de cate ori va afisa ah 9 int 10h aceeasi chestie
mov	si,offset text ;    get the offset of the text variable
iar:
	mov	ah,2  ;         set the cursor position for int 10h (dh row dl column)
	int	10h
	lodsb         ;     load the next character from the text variable into al
	cmp	al,'$'  ;       see if you reached the end
	jz	endtext
	mov	ah,9   ;        prepare the display mode for int 10h
	int	10h
	inc	dl     ;        increment cursor position
	jmp	iar
endtext:
	    
mov cl, es:[80h];  number of arguments
mov di, 81h;    ;  pozitia primului argument in DI pt ca DI pointeaza in ES

nimic:  
                
mov	ah,2h      ;   set the cursor position
int	10h  

mov al, [di];      pune in al argumentu gasit in ES la adresa [DI]

;cmp al, ' ';      daca vr sa scapi de spatii
mov	ah,9h   ;      prepare the display mode for int 10h
int	10h 
inc	dl   ;         increment cursor position
inc di   ;         increment pozitie in ES (next arg)

loop nimic       ; loop pana cand se termina caracterele   


ret                   
