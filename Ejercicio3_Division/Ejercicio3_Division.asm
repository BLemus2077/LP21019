section .data
    mensajeDividendo db "Ingrese el dividendo:  ", 10, 0
    mensajeDivisor   db "Ingrese el divisor:  ", 10, 0
    mensajeCociente  db "Cociente:  ", 10, 0
    mensajeResiduo   db "Residuo:  ", 10, 0
    saltoLinea       db 10
    bufferEntrada    times 11 db 0  ; Buffer para entrada (10 dígitos)

section .bss
    valorDividendo resd 1
    valorDivisor resd 1
    valorCociente resd 1
    valorResiduo resd 1

section .text
    global _start

_start:
    ; Solicitar y leer dividendo
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeDividendo
    mov edx, 21
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 11
    int 0x80
    call convertir_a_entero32
    mov [valorDividendo], eax

    ; Solicitar y leer divisor
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeDivisor
    mov edx, 20
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 11
    int 0x80
    call convertir_a_entero32
    mov [valorDivisor], eax

    ; Realizar división
    mov eax, [valorDividendo]
    xor edx, edx
    div dword [valorDivisor]
    mov [valorCociente], eax
    mov [valorResiduo], edx

    ; Mostrar cociente
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeCociente
    mov edx, 10
    int 0x80
    
    mov eax, [valorCociente]
    call imprimir_entero32

    ; Mostrar residuo
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeResiduo
    mov edx, 9
    int 0x80
    
    mov eax, [valorResiduo]
    call imprimir_entero32

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

convertir_a_entero32:
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

imprimir_entero32:
    mov edi, bufferEntrada + 10
    mov byte [edi], 0
    mov ecx, 10
    
.convertir:
    dec edi
    xor edx, edx
    div ecx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz .convertir
    
    mov edx, bufferEntrada + 11
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
