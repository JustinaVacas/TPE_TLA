#!/bin/bash

./braille < $1 > intermedio.c 

if [ $? -ne 255 ] 
then

    gcc intermedio.c -o $2

else
    echo "Aviso: falta corregir errores para compilar sin problemas"
fi