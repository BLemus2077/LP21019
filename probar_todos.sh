#!/bin/bash

echo "=== PRUEBA INTERACTIVA DE LOS EJERCICIOS ==="
echo "Directorio actual: $(pwd)"
echo ""

echo "=== Ejercicio1_Resta ==="
cd /home/bryan2077/Ejercicios_DEC/Ejercicio1_Resta
nasm -f elf32 Ejercicio1_Resta.asm -o Ejercicio1_Resta.o
ld -m elf_i386 Ejercicio1_Resta.o -o Ejercicio1_Resta
./Ejercicio1_Resta
cd ..

echo -e "\n=== Ejercicio2_Multiplicacion ==="
cd /home/bryan2077/Ejercicios_DEC/Ejercicio2_Multiplicacion
nasm -f elf32 Ejercicio2_Multiplicacion.asm -o Ejercicio2_Multiplicacion.o
ld -m elf_i386 Ejercicio2_Multiplicacion.o -o Ejercicio2_Multiplicacion
./Ejercicio2_Multiplicacion
cd ..

echo -e "\n=== Ejercicio3_Division ==="
cd /home/bryan2077/Ejercicios_DEC/Ejercicio3_Division
nasm -f elf32 Ejercicio3_Division.asm -o Ejercicio3_Division.o
ld -m elf_i386 Ejercicio3_Division.o -o Ejercicio3_Division
./Ejercicio3_Division
cd ..
