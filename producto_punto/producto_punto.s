section .data
nombre db "listas.txt",0

mensj1:     db "primera lista = %08X",0x0a,0    

mensj2:     db "segunda lista = %08X",0x0a,0    

section .bss
fd:	resq 1
buffer:	resb 80

vec1: resq 8
vec2: resq 8

suma: resq 8
punto: resq 1

section .text

global main 
extern printf

main:		
    push rbp
    mov rbp,rsp
    sub rsp,48 ;para depuracion
    push rbx

    mov rax,02	;sys_open
    mov rdi,nombre
    mov rsi,0102o	;escritura_lectura
    mov rdx,0666o	;permisos  0110 0110 0110
    syscall		; abrir descriptor de archivo
    
    mov rbx,fd
    mov    [rbx],rax	;guardar rax(descriptor) en fd
    mov    rax, 0          ; syscall  leer archivo(sysread)
    mov    rdi, [rel fd]       ; descriptor
    mov    rsi, buffer    
    mov    rdx, 0x10	;por ejemplo ..linea de 80 chars
    syscall

    mov rcx, 8
    mov rdi, vec1
    mov rsi, buffer
    bucle:
        mov rax, [rsi]
        mov [rdi], rax
        
        add rdi,8
        add rsi,8

        dec cl
        jnz bucle
    
    mov rcx, 8
    mov rdi, vec2
    bucle2:
        mov rax, [rsi]
        mov [rdi], rax
        
        add rdi,8
        add rsi,8

        dec cl
        jnz bucle2

    mov rcx, 8
    mov rsi, vec1
    bucle3:
        mov rax, [rsi]
        push rax
        push mensj1
        call printf
        add rsp, 8
        
        add rsi, 8
        dec rcx
        jnz bucle3

    mov rcx, 8
    mov rsi, vec2
    bucle4:
        mov rax, [rsi]
        push rax
        push mensj2
        call printf
        add rsp, 8
        
        add rsi, 8
        dec cl
        jnz bucle4

    mov rax, 3             ; cerrar archivo (sysClose)
    mov rdi, [rel fd]          ; descriptor  
    syscall

    pop rbx        
    add rsp,48
    mov rsp,rbp
    pop rbp
    
    mov rax,60
    mov rdi,0
    syscall
    