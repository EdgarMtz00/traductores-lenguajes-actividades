section .data
msgImaginarios: db "Los resultados son imaginarios", 10, 0
fms: db "%s",0
fmr: db "%d",0
pmr: db "%d",10,0
a: dq 1
b: dq 6
c: dq 9

section .bss
res: resq 2
int64 resq 1

section .text
extern printf
extern scanf
global main

main:

    mov rdi, a
    mov rsi, b
    mov rdx, c
    mov rcx, res
    xor rax, rax
    

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

    mov [rcx + 1], rax
    mov rax, rcx
    jmp final

imaginarios:
    mov rax, 0

final:
    cmp rax, 0
    jnz resultados
	
    mov rax,0
	mov rdi,fms
	lea rsi,[rel msgImaginarios]
	call printf WRT ..plt
    jmp fin

resultados:
    mov rax,0
	mov rdi,pmr
	mov rsi,[rel res]
	call printf WRT ..plt

    mov rax,0
	mov rdi,pmr
	mov rsi,[rel res + 8]
	call printf WRT ..plt
fin:
    mov rax, 60
    mov rdi, 0
    syscall

