bits    64

default rel

global  main

extern  scanf
extern  printf

section .data
    scanFormat      db '%s', 0
    printFormat     db '%s', 0xA, 0

section .bss
    input           resb 1024
    output          resb 1024

section .text
    main:
        sub rsp, 8 

        ;Using scanf to get an input string
        lea rsi, [input]
        lea rdi, [scanFormat]
        mov al, 0

        call scanf wrt ..plt

        ;get strlen
        lea rdi, [input]
        sub rcx, rcx
        not rcx
        sub al, al
        cld
        repne scasb
        not rcx

        ;quick strcpy
        lea rsi, [input]
        lea rdi, [output]

        rep movsb

        ;Prinitng output string
        lea rsi, [output]
        lea rdi, [printFormat]
        mov al, 0

        call printf wrt ..plt

        add rsp, 8

        sub rax, rax
        ret