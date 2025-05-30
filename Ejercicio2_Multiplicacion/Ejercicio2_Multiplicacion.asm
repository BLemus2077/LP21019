section .data
    mensajeFactor1   db "Ingrese el 1° factor (0-255):  ", 10, 0
    mensajeFactor2   db "Ingrese el 2° factor (0-255):  ", 10, 0
    mensajeProducto  db "El producto es:  ", 10, 0
    saltoLinea       db 10
    bufferEntrada    times 4 db 0  ; Buffer para entrada (3 dígitos + enter)

section .bss
    factorUno resb 1
    factorDos resb 1
    producto resw 1

section .text
    global _start

_start:
    ; Solicitar y leer primer factor
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeFactor1
    mov edx, 31
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 4
    int 0x80
    call convertir_a_entero8
    mov [factorUno], al

    ; Solicitar y leer segundo factor
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeFactor2
    mov edx, 32
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, bufferEntrada
    mov edx, 4
    int 0x80
    call convertir_a_entero8
    mov [factorDos], al

    ; Realizar multiplicación
    mov al, [factorUno]
    mov bl, [factorDos]
    mul bl
    mov [producto], ax

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, mensajeProducto
    mov edx, 16
    int 0x80
    
    mov ax, [producto]
    call imprimir_entero
    
    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

convertir_a_entero8:
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

imprimir_entero:
    mov edi, bufferEntrada + 5
    mov byte [edi], 0
    mov ecx, 10
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
