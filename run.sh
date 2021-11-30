#!/bin/bash

./braille < $1 > my_program.c 

gcc my_program.c -o $2

echo "Programa compilado."
