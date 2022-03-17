section .bss
int64 resq 1
section .text
global raiz2:


raiz2:

    mov rax, [rdi]
    mov rbx, [rdx]
    mul rbx

    mov rbx, 4
    mul rbx
    mov rbx, rax

    mov rax, [rsi]
    mul rax

    sub rax, rbx
    js imaginarios

    mov [rel int64], rax
    fld qword[rel int64]
    fsqrt
    fstp qword[rel int64]

    mov rax, [rel int64]

    mov rbx, [rsi]
    add rbx, rax
    push rax
    push rbx
    
    mov rax, [rdi]
    mov rbx, 2
    mul rbx
    pop rbx
    xchg rax, rbx
    div rbx

    mov [rcx], rax

    pop rax
    mov rbx, [rsi]
    sub rbx, rax
    push rbx

    mov rax, [rdi]
    mov rbx, 2
    mul rbx
    pop rbx
    xchg rax, rbx
    div rbx

    mov qword [rcx + 8], rax
    mov rax, rcx
    jmp final

imaginarios:
    mov rax, 0

final:
    ret
