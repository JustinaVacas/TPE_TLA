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
chmod +x ./install.sh
./install.sh
chmod +x ./compile.sh
./compile.sh test.braille results
```

De esta manera se va a obtener el ejecutable:

```bash
./results
```

## Programas de ejemplo

Se encuentran bajo la carpeta [`examples`](./examples)

## Gramática

* Permite asignar variables de tipo texto:
```
texto [variable] es [valor]
```
* Permite asignar variables de tipo braille:
```
braille [variable] es [valor]
```
* Permite imprimir por pantalla:
```
print [variable]
```
* Permite traducir la palabra sea a texto o a braille:
```
traducir [variable]
```