    org 100h
jmp start
 
str DB 256 DUP(?)
 
start:     
 
    mov di, offset str;
    cld; 
    xor cx, cx;
    alt:
     mov ah, 0;       ;read char
     INT 16h;         ;kb interrupt
     cmp al, 1Bh;
     jz gata;     
     stosb   
     inc cx; 
     mov ah, 0eh;     ;display char with cursor increment
     INT 10h;         ;display interrupt
     jmp alt;
gata:       
ret