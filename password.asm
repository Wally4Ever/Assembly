; Now, develop the solution above to write a macro called scanstr str to read and store the string at
; the address str in memory. Use this macro in a program that will display first „Please enter your
; password: „, then it will read a string containg the passord and it just stored it in memory.

org 100h
         
jmp start

enterpass DB "Please enter your password: ", "$"
allowed DB "Welcome to the system!", "$"
denied DB "Password incorrect!", "$"
endl DB 0Dh, 0Ah, "$"                           

pwd DB "pass", 0Dh
passlength DW 5    ;nu merge sa calculeze automat cu len EQU $-pwd

str DB 256 DUP(?)
length DW ?

scanstr MACRO s
    mov di, offset s     ;pt stocare in string
    xor cx, cx
    cld                  ;procesare string cresc

next:
    ; read character    
    mov ah, 0
    int 16h
    
    ; if we got Enter, end reading      
    cmp al, 0Dh
    jz endscan
    stosb
    
    ; show * in place of characters
    inc cx
    mov al, '*'
    mov ah, 0Eh
    int 10h
 
    jmp next
    
endscan:
    stosb         
    inc cx            ;lungimea se calculeaza pe parcurs. +1 la fiecare char
    mov length, cx      
scanstr ENDM

print MACRO s             ;macro care afiseaza string
    mov dx, offset s
    mov ah, 9
    int 21h    
print ENDM

start:
    print enterpass ; prompt user to input pass
    scanstr str     ; read password
         
    ; check whether password lengths match
    mov ax, length
    mov bx, passlength
    cmp ax, bx
    jnz access_denied
                                        
    ; compare strings for cx bytes
    mov cx, length
    mov si, offset pwd
    mov di, offset str
    cld

    repe cmpsb   ;repeat comparison between si and di until cx 0 or different
    cmp cx, 0
    jnz access_denied
    print endl
    print allowed
    jmp done

access_denied:
    print endl
    print denied

done:
ret
    