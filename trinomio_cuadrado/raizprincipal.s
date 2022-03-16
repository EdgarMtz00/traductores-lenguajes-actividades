section .data
msgIngresar: db "Ingrese A, B y C", 10, 0
msgImaginarios: db "Los resultados son imaginarios", 10, 0
fms: db "%s",0
fmr: db "%lf",0
a: dq 1
b: dq 6
c: dq 9

section .bss
res: resq 2
int64 resq 1

section .text
extern printf
extern scanf
extern raiz2
global main

main:
	push rbp
	mov rbp,rsp
	sub rsp,48
	push rbx

    mov rdi, a
    mov rsi, b
    mov rdx, c
    mov rcx, res
    xor rax, rax
    call raiz2
    
    cmp rax, 0
    jnz resultados
	
    mov rax,0
	mov rdi,fms
	lea rsi,[rel msgImaginarios]
	call printf WRT ..plt

resultados:

fin:
    pop rbx
    add rsp,48
    mov rsp,rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall

raiz2:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    push rbx

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

    mov [rdx], rax

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

    add rdx, 8
    mov [rdx], rax
    sub rdx, 8
    mov rax, rdx
    jmp final

imaginarios:
    mov rax, 0

final:
    pop rbx
    add rsp, 48
    mov rsp, rbp
    pop rbp
    ret
