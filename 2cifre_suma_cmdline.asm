org 100h
jmp start;
text DB "The result of sum is: "  

value DB ? , '$'; 
       
start:
mov al, es:[82h];  1st number in al
sub al, 30h;       convert in binary
mov bl, es:[84h];  the 2nd number
add al, bl;  
mov [value], al
mov dx, offset text
mov ah,9h;
int 21h ;          display 
ret                   

;adauga 2 numere de o cifra din command line