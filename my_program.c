#include <stdio.h> 
#include <stdlib.h> 
#include "list.h" 
#include "braille.h" 
#include <string.h> 

int main(){ 
int aux = 5;
printf("Inicio");
printf("\n");
do { 
aux = aux - 1;
printf("%d", aux);
printf("\n");
braille_to_text();
} while (aux>0);

return 0;}