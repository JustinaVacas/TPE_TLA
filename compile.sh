#!/bin/bash

./braille < $1 > my_program.c 

if [[ $? == 0 ]]; 
    then

        gcc -w my_program.c list.c braille.c -o $2
fi

