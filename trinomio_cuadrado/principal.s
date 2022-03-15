section .data
msgIngresar: db "Ingrese A, B y C", 10, 0
msgImaginarios: db "Los resultados son imaginarios", 10, 0
fms: db "%s",0
fmr: db "%lf",0

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
    
    mov  rax, 0       ; clear AL (zero FP args in XMM registers)
    mov  edi, fmr       ; load format string
    mov  esi, b 
    call scanf
    
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

fin:
    pop rbx
    add rsp,48
    mov rsp,rbp
    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall
