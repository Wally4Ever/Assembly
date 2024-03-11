                    org 100h
jmp start
 
str DB 256 DUP(?);
mesaj DB 'Introduceti parola: ', '$';    
pwd DB '123', 0dh;   
lung EQU $-pwd;
welcome DB 0dh, 0ah, 'Bine ai venit in sistem! ', '$';
denied DB 0dh, 0ah, 'Parola este incorecta! ', '$';                       
scanstr MACRO s     
     mov di, offset s;
     cld;
     alt:
          mov ah,0h;
          INT 16h;  
          stosb;
          cmp al, 0dh;  
          jz gata;
 
          mov ah, 0eh;
          mov al, '*';
          INT 10h;  
          jmp alt;            
     gata:                   
scanstr ENDM  
 
print MACRO s     
     mov dx, offset s;
     mov ah, 09h;
     int 21h;      
print ENDM
 
start:            
     print mesaj;
     scanstr str;      
     mov si, offset pwd;
     mov di, offset str;   
     mov cx, lung;
     repe cmpsb
     jz equal;
     jnz diff;  
  equal:
     dec di;
     cmp di, 0dh;
     jz diff;
     print welcome; 
     jmp done;
  diff:
     print denied;
  done: 
ret