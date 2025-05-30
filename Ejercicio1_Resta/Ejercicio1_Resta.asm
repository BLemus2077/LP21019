section .data
    mensajeInicial    db "Ingrese 3 numeros a restar:", 10, 0
    mensajePrimero    db "1° numero: ", 0
    mensajeSegundo    db "2° numero: ", 0
    mensajeTercero    db "3° numero: ", 0
    mensajeResultado  db "Resultado: ", 0
    signoNegativo     db "-", 0
    saltoLinea        db 10
    bufferEntrada     times 6 db 0  ; Buffer para entrada (5 dígitos + enter)

section .bss
    primerNumero resw 1
    segundoNumero resw 1
    tercerNumero resw 1
    resultado resw 1

section .text
    global _start

_start:
    ; Mensaje inicial
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeInicial
    mov edx, 25
    int 0x80

    ; Solicitar y leer primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajePrimero
    mov edx, 11
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 6
    int 0x80
    call convertir_a_entero
    mov [primerNumero], ax

    ; Solicitar y leer segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeSegundo
    mov edx, 11
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 6
    int 0x80
    call convertir_a_entero
    mov [segundoNumero], ax

    ; Solicitar y leer tercer número
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeTercero
    mov edx, 11
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 6
    int 0x80
    call convertir_a_entero
    mov [tercerNumero], ax

    ; Realizar la resta
    mov ax, [primerNumero]
    sub ax, [segundoNumero]
    sub ax, [tercerNumero]
    mov [resultado], ax

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeResultado
    mov edx, 11
    int 0x80
    
    mov ax, [resultado]
    call imprimir_entero_con_signo
    
    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

convertir_a_entero:
    xor eax, eax
    mov esi, bufferEntrada
    mov ecx, 0
.convertir:
    movzx edx, byte [esi+ecx]
    cmp dl, 10  ; Verificar fin de línea
    je .listo
    cmp dl, 0   ; Verificar null terminator
    je .listo
    sub dl, '0'
    imul eax, 10
    add eax, edx
    inc ecx
    jmp .convertir
.listo:
    ret

imprimir_entero_con_signo:
    mov edi, bufferEntrada + 5
    mov byte [edi], 0
    mov ecx, 10
    
    ; Verificar si es negativo
    test ax, ax
    jns .positivo
    
    ; Imprimir signo negativo
    push ax
    mov eax, 4
    mov ebx, 1
    mov ecx, signoNegativo
    mov edx, 1
    int 0x80
    pop ax
    neg ax
    
.positivo:
    mov bx, ax
.convertir:
    dec edi
    xor dx, dx
    div cx
    add dl, '0'
    mov [edi], dl
    test ax, ax
    jnz .convertir
    
    mov edx, bufferEntrada + 6
    sub edx, edi
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, saltoLinea
    mov edx, 1
    int 0x80
    ret
