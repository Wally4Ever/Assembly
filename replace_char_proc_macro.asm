org 100h

; problem 4
jmp start
          
sir1 DB 'goose'

cmp_replace PROC NEAR
setup:
    mov si, offset sir1
    mov cx, 7   ; str1 length
    mov al, 5   ; value to find
    mov bl, 10  ; value to replace
comp:
    cmp [si], al
    jne continue
    mov [si], bl
continue:
    inc si
    loop comp             
    ret
cmp_replace ENDP 

replace MACRO str, len, f, r
setup2:
    mov si, offset str
    mov cx, len ; str1 length
    mov al, f   ; value to find
    mov bl, r   ; value to replace
comp2:
    cmp [si], al
    jne continue
    mov [si], bl
continue2:
    inc si
    loop comp             
    ret
replace ENDM
   
start:
    ;call cmp_replace ; PROC call 
    replace sir1, 5, 'o', 'e' ; MACRO call
   
ret