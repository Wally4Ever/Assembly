org 100h
jmp start
 
str DB 256 DUP(?);
 
start:     
 
     mov di, offset str;
     cld;
  alt:
     mov ah, 01h;     ;kb to screen
     INT 21h;         
     cmp al, 1bh;     ;compara cu esc
     jz gata;
     stosb;           ;stocheaza in memorie pointata de di
     jmp alt;
gata: 
ret
 