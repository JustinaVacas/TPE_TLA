#!/bin/bash

./braille < $1 > my_program.c 

gcc -w my_program.c list.c braille.c -o $2

echo "Programa compilado."
