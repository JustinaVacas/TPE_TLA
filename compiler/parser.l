%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "node.h"
	#include "y.tab.h" 
%}

%option noyywrap

string			\"[^\"]*\"
intnumber      	-?[0-9]+?
variable_int  		[a-zA-Z0-9]+
variable_string		[a-zA-Z0-9]+

%%

"texto"			        { return CREATE_VARIABLE_STRING; }
"num"      	            { return CREATE_VARIABLE_INT; }
"es"			        { return ASSIGN; }
"traducir"				{ return TRANSLATE; }
"print"					{ return PRINT; }
"print_b"				{ return PRINT_B; }
"dividir_en"			{ return DIVIDE_ASSIGN; }
"contraer"				{ return CONTRACTION; }
"si"					{ return IF; }
"entonces"				{ return ELSE; }
"\n"  					{ yylineno++; return NEW_LINE; }

{intnumber}        		{ strcpy(yylval.buffer, yytext); return INT; }
{variable_int}    		{ strcpy(yylval.buffer, yytext); return VARIABLE_INT; }
{variable_string}    	{ strcpy(yylval.buffer, yytext); return VARIABLE_STRING; }
{string}				{ strcpy(yylval.buffer, yytext); return STRING; }
.

%%

// 2 tipos de input que se indican con las palabras "braille" y "texto"

/* EJEMPLOS 

1-  Imprimir texto a braille -------------------------------------------

texto aux es joji               	--> asigna variable_text 	
traducir aux                        --> traduce a braille
print aux --> 245.153.245.24

texto aux2 es hola como estas  		--> asigna variable_text
traducir aux2						--> traduce a braille
print aux2 --> 125.132.123.1 14.153.143.153 15.423.4523.1.234

//////////////////////////////////
texto aux es hola

while(aux){
	//
	traducir(aux);
	//
}

print(aux);

2- Imprimir braille a texto -------------------------------------------

braille aux es 245.153.245.24		--> asigna variable_braille
traducir aux                        --> traduce a texto      
print aux --> joji					--> imprime traduccion

braille aux2 es 125.132.123.1 14.153.143.153 15.423.4523.1.234	--> asigna variable_braille
traducir aux2													--> traduce a texto		
print aux2 -->  hola como estas 								--> imprime traduccion

3- Contracciones ------------------------------------------------------

texto aux es fiesta
contraccion aux
traducir
print aux --> 124.24.1246.2345.1

(en realidad fiesta es: 124.24.15.234.2345.1)

4- Operaciones aritmeticas --------------------------------------------

texto aux es joji
texto aux dividir_en 2
print aux --> jo ji

5- IF ------------------------------------------------------

si aux traducir

*/

/*
El mismo debe contener obligatoriamente y como minimo:

- Tipos de datos: numerico y cadenas.
- Constantes, Delimitadores.
- Operadores aritmeticos, relacionales, logicos, de asignacion.
- Bloque Condicional (if).
- Bloque Do-While (repeticion hasta condicion).
*/
