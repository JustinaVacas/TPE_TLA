/*ESTRUCTURA

%{
    DECLARACIONES
%}
definiciones
%%{
    PRODUCCIONES Y REGLAS DE TRADUCCION (y las acciones semanticas asociadas a las prod)
%}
{ RUTINAS DE C}
*/

%{
	#include <stdio.h>
%}

%union {
 	
}

/*En la parte de definiciones se define los token, todos los terminales
con start marcamos el distinguido*/ 

%token ASSIGN
%token TRANSLATE
%token PRINT
%token PRINT_B
%token DIVIDE_ASSIGN
%token CONTRACTION
%token CREATE_VARIABLE_BRAILLE
%token CREATE_VARIABLE_TEXT
%token IF

/* reglas de traduccion
left_side : right side
    { syntactic action }
    | right side 2 { action C-snippt 2}
    | right side 3 { action C-snippet 3}

EJEMPLO
expr : termino ‘*’ factor
     {
    $$ = $1 * $3;   (el 1 representa el valor asociado que tiene el termino y el 3 asociado a factor)
    }
    | factor
    ;

 */