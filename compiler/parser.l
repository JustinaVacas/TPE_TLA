%{
	#include <stdio.h>
	#include <stdlib.h>
%}

%option noyywrap

string			\"[^\"]*\"
intnumber      	-?[0-9]+?
variable  		[a-zA-Z0-9]+

%%

"braille"		        { return CREATE_VARIABLE_BRAILLE; }
"texto"                 { return CREATE_VARIABLE_TEXT; }
"es"			        { return ASSIGN; }
"print"					{ return PRINT; }
"cortar_en"				{ return CUT_ASSIGN; }
"contraer"				{ return CONTRACTION; }

{intnumber}        		{ strcpy(yylval.buffer, yytext); return INT; }
{variable}    			{ strcpy(yylval.buffer, yytext); return VARIABLE; }
{string}				{ strcpy(yylval.buffer, yytext); return STRING; }
.

%%

// 2 tipos de input que se indican con las palabras "braille" y "texto"

/* EJEMPLOS 

1-  Imprimir texto a braille

texto aux es joji               --> traduce a braille
print aux --> 245.153.245.24

texto aux2 es hola como estas  
print aux2 --> 125.132.123.1 14.153.143.153 15.423.4523.1.234

2- Imprimir braille a texto

braille aux es 245.153.245.24      --> traduce a texto
print aux --> joji

braille aux2 es 125.132.123.1 14.153.143.153 15.423.4523.1.234
print aux2 -->  hola como estas 

3- Contracciones

texto aux es fiesta
contraccion aux
print aux --> 124.24.1246.2345.1

(en realidad fiesta es: 124.24.15.234.2345.1)

4- Operaciones aritmeticas

texto aux es joji
texto aux cortar_en 2
print aux --> jo ji

*/