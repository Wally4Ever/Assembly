org 100h

; ax = 1/8 * al + 8 * bl

; 1/8 * al
mov al, 8
mov bl, 1
div bl		; 1/8
mov bl, al	; move result to bl
mov al, 5	; set factor
mul bl		; ax = 1/8 * al
mov cx, ax	; save result in cl

; 8 * bl
mov al, 8
mov bl, 10	; set factor
mul bl

; addition
add ax, cx

ret
