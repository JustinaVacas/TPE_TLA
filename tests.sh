#!/bin/bash

for i in {1..7}; do 
	echo "-------------------------------------"
	echo "Ejemplo ${i}:"
	./compile.sh ./ejemplos/ejemplo${i}.braille ejemplo${i}.out
	./ejemplo${i}.out
	echo "-------------------------------------";
done
