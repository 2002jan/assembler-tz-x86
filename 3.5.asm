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


    bubbleSort:

        mov r15, 0

    outerLoop:

        cmp r15, [n]

        jge endOuterLoop

        mov rcx, [n]
        sub rcx, 1

    innerLoop:

        cmp rcx, r15

        jle endInnerLoop

        lea rsi, [array]
        lea rsi, [rsi + rcx * 4]
        lea rdi, [rsi - 4]

        mov eax, dword [rsi]

        cmp dword [rdi], eax

        jle endXCHG

        xchg dword [rdi], eax
        mov dword [rsi], eax

    endXCHG:

        loop innerLoop

    endInnerLoop:

        inc r15

        cmp r15, [n]

        jl outerLoop

    endOuterLoop: 

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