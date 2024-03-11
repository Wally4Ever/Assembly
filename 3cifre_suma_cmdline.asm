         org 100h
jmp start;
text DB "The result of sum is: "  

value DB 2 dup(?), "$"; 
       
start:
mov al, es:[82h];  1st number in al
sub al, 30h;       convert in binary
mov bl, es:[84h];  the 2nd number
add al, bl;  
mov bl, es:[86h];  the 3rd number
sub bl, 30h;
add al, bl;  

cmp al, '9';       verif daca >9
jg doua_CIFRE 

mov [value], al
mov dx, offset text  
jmp gata;          sari la afis

doua_CIFRE: 
                  ;convert
sub al, 30h;      ;ASCII TO HEX
mov cl, 10;  
div cl;    
add al, 30h;      ;HEX TO ASCIIs
add ah, 30h;
mov [value], al         
mov [value+1], ah  
xor ax, ax 
mov dx, offset text  

gata:   

mov ah,9h; 

int 21h ;          display 
ret                   

;adauga trei numere de o cifra din command line