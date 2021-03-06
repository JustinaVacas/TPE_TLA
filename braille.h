#ifndef BRAILLE_H
#define BRAILLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>

void print_braille(char * text);
void print_braille_num(int numero);
void read_and_traduce();
void print_traduce(char * stdin_braille);
void prt_braille(char * braille);
void prt_text(char* braille);
char * traduce(char * variable_name, int type);
char * concat(char * var1, int type1, char * var2, int type2);

#endif