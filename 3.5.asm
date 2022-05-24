bits    64

default rel

global  main

extern  scanf
extern  printf

section .data
    scanFormat      db '%d', 0
    printFormat     db '%d ', 0

section .bss
    array           resd 100
    n               resd 1

section .text
    main:
        sub rsp, 8 
        lea r15, [array]

    scanningWhile:

        mov rsi, r15
        lea rdi, [scanFormat]
        mov al, 0
        mov rax, 0

        call scanf wrt ..plt        

        cmp rax, 1

        jne endScanningWhile

        add r15, 4
        inc	dword [n]

        jmp scanningWhile

    endScanningWhile:

        lea r15, [array]
        mov r14, 0
        
    pritingFor:

        mov rsi, [r15]
        lea rdi, [printFormat]
        mov al, 0

        call printf wrt ..plt

        add r15, 4
        inc r14

        cmp r14, [n]

        jl pritingFor

        add rsp, 8

        sub rax, rax
        ret