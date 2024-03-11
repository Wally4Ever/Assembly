org 100h

jmp start
;Write a program to read from the keyboard a decimal number of 
;maximum four digits and to display on the screen the sum of 
;its corresponding digits.
errmsg  DB 'Try again! Wrong input!', '$';
str DB 3 DUP(?)
 
start:     
    xor bx, bx;        bx sa fie 0 pentru calc suma
    mov di, offset str;
    cld; 
    xor cx, cx;
    alt:
     mov ah, 0;       ;read char
     INT 16h;         ;kb interrupt
     cmp al, 1Bh;     ;esc cand s-a introdus nr
     jz gata;        ;sari la suma daca ESC
     cmp al, '0'      ;verificam daca e cifra
     jl error
     cmp al, '9'
     jg error 
     
     stosb            ;es:[di] = al AND di++
     inc cx;          ;numeri lungimea la ce ai citit
     
     mov ah, 0eh;     ;display char with cursor increment
     INT 10h;         ;display interrupt
     jmp alt;         ;revino la citit cifre
gata: 
    mov al, ' ';     ;afis un spatiu
    mov ah, 0eh;     ;display char with cursor increment
    INT 10h;
    cmp cx, 4
    jg error    
  repet:             ;repeta cat timp sunt cifre 
    dec di;
    mov al, es:[di]; ;pune cifra in al
    sub al, 30h;      convert in binary
    add bl, al;       adauga cifrele in BL  
  loop repet;      
    
cmp bl, 9h;       verif daca >9
jg doua_CIFRE
mov al, bl;   
add al, 30h; 
mov ah, 0eh;     ;display char with cursor increment
INT 10h; 
jmp final;          sari la final
     
                  
                  
doua_CIFRE: 
xor ax, ax;
mov al, bl;               
 
mov cl, 10;  
div cl;   
mov bl, ah;
add al, 30h;     ;convert to ascii
mov ah, 0eh;     ;display char with cursor increment
INT 10h;  
mov al, bl; 
add al, 30h;     ;convert to ascii
mov ah, 0eh;     ;display char with cursor increment
INT 10h; 
jmp final;

error:
    mov dx, offset errmsg;  
    mov ah, 09h;
    int 21h; 

final:    
ret