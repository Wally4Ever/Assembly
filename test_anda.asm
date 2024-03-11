org 100h

jmp start   

mesaj DB 'The sum is: ', '$';
arr DB 2, 2, 1, 1, 1, 1, 2, 2, 2, 9, '$'
 

start:
    ;AFIS MESAJ 
    mov dx, offset mesaj;
    mov ah, 09h;
    int 21h; 
    ;PREGATIRE PROCESARE ARRAY  
    mov si, offset arr; 
    xor bx, bx;             ;calc suma in bl, asa ca resetam la 0
    mov cx, 0;         
alt:    

     lodsb                  ;urmatoarea cifra in 
     cmp al, '$';           ;daca e $ e gata sir
     jz afis;               ;sari la final
     add bl, al;            ;daca e cifra aduna
     inc cx;                ;numeri cate cifre ai citit
     jmp alt;               ;revino la citit din arr     
afis: 
     cmp cx, 9;
     jg gata;               ;daca s-au citit mai mult de 9 cifre, sari la final
     cmp bl, 9;             ;verif daca  suma >9
     jg doua_CIFRE          ;daca mai mare, se trateaza diferit
     mov al, bl;            ;pune suma in al   
     add al, 30h;           ;transform in ASCII
     mov ah,0eh             ;pt afisare
	 int 10h  
     jmp gata;              ;sari la final

doua_CIFRE: 
     xor ax, ax;            ;ax e 0
     mov al, bl;            ;pune suma in al   
     mov cl, 10;            ;rest in al, catul in AH
     div cl;            
     add al, 30h;           ;transform in ASCIIs
     add ah, 30h;           ;ascii
     mov dh, ah;            ;salveaza ah pentru ca ah se foloseste la interrupt
     mov ah,0eh             ;pt afisare
	 int 10h                ;se afiseaza AL
	 mov al, dh;            ;se puen in AL ce era inainte in AH
	 int 10h                ;afisare
       
gata:   
     ret;