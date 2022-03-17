section .data
msgIngresar: db "Ingrese A, B y C", 10, 0
msgImaginarios: db "Los resultados son imaginarios", 10, 0
msgResultado: db "El resultado es", 10, 0
pmr: db "%d",10,0
fms: db "%s",0
fmr: db "%d",0
z dq 1

section .bss
a:  resq 1
b:  resq 1
c:  resq 1
res: resq 2

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

	mov rax,0
	mov rdi,fms
	lea rsi,[rel msgIngresar]
	call printf WRT ..plt

    push rbp           ; keep stack aligned
    mov  rax, 0       ; clear AL (zero FP args in XMM registers)
    mov  edi, fmr       ; load format string
    mov  esi, a 
    call scanf
    pop rbp

    push rbp
    mov  rax, 0       ; clear AL (zero FP args in XMM registers)
    mov  edi, fmr       ; load format string
    mov  esi, b 
    call scanf
    pop rbp

    push rbp
    mov  rax, 0       ; clear AL (zero FP args in XMM registers)
    mov  edi, fmr       ; load format string
    mov  esi, c 
    call scanf
    pop rbp

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
    mov rax,0
	mov rdi,fms
	lea rsi,[rel msgResultado]
	call printf WRT ..plt

    xor rbx, rbx
    mov bx, [rel res]
    mov rax,0
	mov rdi,pmr
	mov rsi, rbx
	call printf WRT ..plt

    xor rbx, rbx
    mov bx, [rel res + 8]
    mov rax,0
	mov rdi,pmr
	mov rsi, rbx
	call printf WRT ..plt
fin:
    pop rbx
    add rsp,48
    mov rsp,rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall
