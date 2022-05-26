bits    64

default rel

global  main

extern  scanf
extern  printf

section .data
    scanFormat      db '%lf', 0
    printFormat     db 'sqrt(%f) = %f', 0xA, 0
    align 16
    change          dq 0.125

section .bss
    end           resq 1

section .text
    main:
        sub rsp, 8 

        lea rsi, [end]
        lea rdi, [scanFormat]
        mov al, 0
        call scanf wrt ..plt

        ;Making sure xmm10/11/12 are 0.000000000000000000
        psubq xmm10, xmm10
        psubq xmm11, xmm11

        movlpd xmm10, [change]

    beginMagicLoop:

        movq  xmm0, xmm11
        cmpltsd xmm0, [end]
        movq    rax, xmm0
        cmp     rax, 0

        jz endMagicLoop
        
        movq xmm2, xmm11
        sqrtsd xmm0, xmm2

        movq xmm1, xmm0
        movq xmm0, xmm11
        lea rdi, [printFormat]
        mov al, 2
        call printf wrt ..plt

        addsd xmm11, xmm10

        jmp beginMagicLoop

    endMagicLoop:

        add rsp, 8

        sub rax, rax
        ret