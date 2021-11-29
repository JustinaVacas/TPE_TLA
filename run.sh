#!/bin/bash

./braille < $1 > ejemplo.c 

if [ $? -ne 255 ] 
then

    gcc ejemplo.c -o $2

else
    echo "Aviso: falta corregir errores para compilar sin problemas"
fi