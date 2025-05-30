# LP21019 - Bryan Ernesto Lemus Pineda

Repositorio con las soluciones a los ejercicios de ensamblador para la asignatura de Diseño y Estructura de Computadoras.

## Contenido

1. **Ejercicio1_Resta**: Programa que resta tres números enteros usando registros de 16 bits
2. **Ejercicio2_Multiplicacion**: Programa que multiplica dos números usando registros de 8 bits
3. **Ejercicio3_Division**: Programa que divide dos números usando registros de 32 bits

## Requisitos

- NASM (Netwide Assembler)
- GNU Linker (ld)
- Linux (para syscalls)

## Compilación y Ejecución

Para cada ejercicio:

nasm -f elf32 [nombre_archivo].asm -o [nombre_archivo].o
ld -m elf_i386 [nombre_archivo].o -o [nombre_ejecutable]
./[nombre_ejecutable]

## Para todos de una vez 

Tambien he creado un archivo .sh que al ejecutarlo pone en ejecucion
los tres ejercicios, solo deden poner los comando de aqui abajo.

chmod +x probar_todos.sh
./probar_todos.sh


AUTOR: Bryan Ernesto Lemus Pineda
CARNET: LP21019
