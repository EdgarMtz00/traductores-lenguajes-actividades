%include "io64.inc"

section .data
n: dq 46
cad: db "Serie fibonacci hasta la iteracion "
lcadn: equ $-cad

section .bss
resp: resb 8
resp2: resb 8


section .text
global CMAIN 
CMAIN:
    mov rbp, rsp; for correct debugging
	push rbp
	mov rbp, rsp
	sub rsp, 48

	push rbx

        PRINT_STRING cad
        PRINT_DEC 8, n
        NEWLINE

    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx

    mov rcx, [rel n]
    mov rax, 0
    mov rbx, 1

ciclo:
    push rcx
    mov rdi, rax
	mov rsi, rbx
	call suma

    mov [rel resp2], rbx
	mov [rel resp], rax

    xor rax, rax
    xor rbx, rbx

    PRINT_DEC 8, resp
    NEWLINE
    
    xor rax, rax
    xor rbx, rbx

    mov rbx, [rel resp]
    mov rax, [rel resp2]
    pop rcx
    dec rcx
    jnz ciclo

	pop rbx ;Finalizar programa
	add rsp, 48
	mov rsp, rbp
	pop rbp
	mov rax, 60
	mov rdi, 0
	syscall

suma:
	mov rax, rdi
	mov rbx, rsi
	add rax, rbx
	ret
