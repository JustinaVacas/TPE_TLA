# Trabajo práctico especial

## Materia
Autómatas, teoría de lenguajes y compiladores

## Autores
* Vacas Castro, Justina
* Assaff, Josefina
* Mejalelaty, Ian
* Fernandez Truglia, Ariadna

## Como compilar y ejecutar

```bash
make
./run.sh ./ejemplos/ejemplo7.braille test
./test
```

## Programas de ejemplo

Se encuentran bajo la carpeta [`examples`](./examples)
Se ejecutan haciendo:
```
make test
```

## Gramática

* Para que el codigo funcione debe comenzar y terminar con:
```
inicio
//codigo
fin
```
* Permite asignar variables de tipo texto:
```
texto [variable] = [valor],
num [variable] = [valor],
```
* Permite imprimir por pantalla:
```
imprimir [variable],
imprimir [valor],
```
* Permite imprimir por pantalla con simbolos braille:
```
imprimir braille [variable],
```
* Permite traducir el texto a braille o al revez, ingresado por entrada estandar:
```
leer y traducir,
braille_a_texto,
```
* Permite realizar ciclos while:
```
hacer:
 //codigo
mientras([condicion]),
```
* Permite realizar ciclos if:
```
si([expresion])
entonces //codigo 
terminado
```
* Permite realizar operaciones aritmeticas:
```
aux = aux + 1,
aux = aux / 1,
aux = aux * 1,
aux = aux - 1,
```