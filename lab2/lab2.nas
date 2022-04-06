global calcs

section .bss 
x       resq    1
y       resq    1
y1      resq    1
y2      resq    1
a       resq    1  
result  resq    10

section .data
two:    dq      2.0
one:    dq      1.0

section .text

calcs:  movq    qword [x], xmm0             ; x = xmm0
        movq    qword [a], xmm1             ; a = xmm1
        mov     rcx, 0                      ; rcx - counter, rcx = 0
        mov     rbx, result                 
step    movq    xmm0, qword [x]             ; xmm0 = x
        mov     rax, __float64__(4.0)       ; rax = 4
        movq    xmm1, rax                   ; xmm1 = rax = 4
        ucomisd xmm0, xmm1                  ; compare floating point values, xmm0 = x, xmm1 = 4
        jbe     y1mult                      ; jump if x<=4
        movq    xmm2, qword [a]             ; xmm2 = a
        subsd   xmm0, xmm2                  ; xmm0 = xmm0 - xmm2 = x - a
        jmp     y1ready
y1mult: mulsd   xmm0, xmm1                  ; xmm0 = xmm0 * xmm1 = x * 4
y1ready:movq    [y1], xmm0                  ; y1 = xmm0 = x - a
        finit                               ; clear FPU
        fld     qword [two]                 ; st0 = 2
        fld     qword [x]                   ; st0 = x, st1 = 2
        fprem                               ; st0 = st0 mod st1 = x mod 2
        fld     qword [one]                 ; st0 = 1, st1 = x mod 2
        fcomi   st0, st1                    ; compare result to 1
        je      y2seven                     ; if x mod 2 = 1, then jump
        fld     qword [x]                   ; st0 = x
        fld     qword [two]                 ; st0 = 2, st1 = x
        fdiv                                ; st0 = st1 / st0
        fld     qword [a]                   ; st0 = a, st1 = x / 2
        fadd                                ; st0 = st1 + st0 = a + (x / 2)
        fstp    qword [y2]                  ; store floating point value, y2 = st0
        jmp     y2ready                     ; jump to skip y2seven
y2seven:mov     rax, __float64__(7.0)       ; rax = 7
        mov     [y2], rax                   ; y = rax = 7
y2ready:movq    xmm0, qword [y1]            ; xmm0 = y1
        movq    xmm1, qword [y2]            ; xmm1 = y2
        addsd   xmm0, xmm1                  ; xmm0 = y1 + y2 = y
        movq    [rbx], xmm0                 ; write y in rbx
        inc     rcx                         ; rcx - counter, rcx = rcx + 1
        add     rbx, 8                      
        movq    xmm1, qword [x]             ; xmm1 = x
        mov     rax, __float64__(1.0)       ; rax = 1
        movq    xmm2, rax                   ; xmm2 = rax = 1
        addsd   xmm1, xmm2                  ; xmm1 = xmm1 + xmm2 = x + 1
        movq    qword [x], xmm1             ; x = xmm1 = x +1
        cmp     rcx, 10                     ; compare rcx and 10
        jb      step                        ; if rcx < 10, then jump to step
        mov     rax, result                 
ret
        

