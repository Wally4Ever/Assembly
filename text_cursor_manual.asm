 org 100h
        
jmp start
text DB "hello there", 0
len EQU $-text-1
spaces DB "           ", 0

print MACRO text
    mov si, offset text
    mov ah, 2   ; write
    int 10h     ; interrupt

r:    
    mov al, [si]
    cmp al, 0
    jz done
    mov ah, 9    ;display al char
    int 10h
    
    inc dl       ;inc cursor location
    inc si       ;change cursor location
    mov ah, 2
    int 10h
    jmp r
    
done:
ENDM 
      
start:
    mov bh, 0   
    mov bl, 00011111b
    mov cx, 1   ; how many times to write it on the screen
    mov dl, 3
    mov dh, 0
    mov ah, 0
                 
l:
    print text
    inc dl
    mov ah, 2
    int 10h
    cmp dl, 80-len
    jle l  
  
ret