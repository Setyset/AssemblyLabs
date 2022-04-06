extern scanf

global calcs

section .bss                    ; data initialization
val1    resq    1
val2    resq    1
result  resq    5

section .text

calcs:  mov     [val1], rdi     ;  val1=x, belongs to rdi
        mov     [val2], rsi     ;  val2=y, belongs to rsi
        
; variant 8     (XY - 1)/(X+Y)
        mov     rax, [val1]     ;  rax = x, start of calculations    
        add     rax, [val2]     ;  rax = x+y
        mov     rbx, rax        ;  rbx = x+y
        mov     rax, [val1]     ;  rax = x again
        imul    qword [val2]    ;  rax = x*y
        dec     rax             ;  rax = xy-1
        cqo
        idiv    rbx             ;  rax = (xy-1)/(x+y)
        mov     [result], rax   
                
; variant 9     X^3 + Y -1
        mov     rax, [val1]     ;  rax = x, start of calculations 
        imul    qword [val1]    ;  ^2
        imul    qword [val1]    ;  ^3
        add     rax, [val2]     ;  rax = x^3+y
        dec     rax
        mov     [result+8], rax

; variant 10    (XY + 1)/ X^2
        mov     rax, [val1]     ;  rax = x, start of calculations
        imul    qword [val1]    ;  ^2
        mov     rbx, rax        ;  rbx = x^2
        mov     rax, [val1]     ;  rax = x
        imul    qword [val2]    ;  rax = x*y
        inc     rax             ;  rax = x*y+1
        cqo
        idiv    rbx             ;  rax = (XY + 1)/ X^2
        mov     [result+16], rax
        
; variant 11    (X+Y)/(X-Y)
        mov     rax, [val1]     ;  rax = x, start of calculations
        sub     rax, [val2]     ;  rax = x-y
        mov     rbx, rax        ;  rbx = x-y
        mov     rax, [val1]     ;  rax = x
        add     rax, [val2]     ;  rax = x+y
        cqo
        idiv    rbx             ;  rax = (X+Y)/(X-Y)
        mov     [result+24], rax

; variant 12    -X^3 + 3
        mov     rax, [val1]     ;  rax = x, start of calculations
        imul    qword [val1]    ;  ^2
        imul    qword [val1]    ;  ^3
        neg     rax
        add     rax, 3          ;  -X^3 + 3
        mov     [result+32], rax

        mov     rax, result     
ret 
