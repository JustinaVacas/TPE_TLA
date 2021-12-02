%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h" 
%}

%option noyywrap

START 		"inicio"
END 		"fin"

DELIMITER 	","

INTEGER 	[-]?[0-9]+
T_BRAILLE   ([0-9]{1,4}[.])*[0-9]{1,4}[.]
STRING 		["][^\n\r]*["]
NUMBER 		"num"
TEXT 		"texto"
BRAILLE 	"braille"
VARIABLE 	[a-zA-Z]+[_0-9A-Za-z]*

ASSIGN 		"="
PLUS 		"+"
MINUS 		"-"
MULTIPLY 	"*"
DIVIDE 		"/"
GREATER 	">"
LOWER 		"<"
EQUALS 		"es"
NOT_EQUALS 	"no es"
AND 		"y"
OR 			"o"
NOT 		"lo contrario a"
TRUE 		"verdadero"
FALSE 		"falso"
IF 			"si"
THEN 		"entonces"
ELSE 		"sino"
END_IF		"terminado"
DO 			"hacer:"
WHILE 		"mientras"
OPEN		"("
CLOSE		")"
PRINT		"imprimir"
NEW_LINE	"linea"
READ_AND_TRADUCE "texto_a_braille"
BRAILLE_TO_TEXT "braille_a_texto"
TRADUCIR	"traducir"


%%

{START} 				return START;
{END} 					return END;
{DELIMITER} 			return DELIMITER;
{READ_AND_TRADUCE}		return READ_AND_TRADUCE;
{BRAILLE_TO_TEXT}		return BRAILLE_TO_TEXT;
{INTEGER} 				{yylval.number=atoi(yytext); return INTEGER;}
{STRING} 				{yylval.string = yytext; return STRING;}
{T_BRAILLE}				{printf("\""); strcat(yytext, "\""); yylval.string = yytext; return T_BRAILLE;}
{TEXT} 					return TEXT;
{NUMBER} 				return NUMBER;
{BRAILLE}				return BRAILLE;
{PLUS} 					return PLUS;
{MINUS} 				return MINUS;
{MULTIPLY} 				return MULTIPLY;
{DIVIDE} 				return DIVIDE;
{LOWER} 				return LOWER;
{GREATER} 				return GREATER;
{EQUALS}  				return EQUALS;
{NOT_EQUALS} 			return NOT_EQUALS;
{OPEN}					return OPEN;
{CLOSE}					return CLOSE;
{AND} 					return AND;
{OR} 					return OR;
{NOT} 					return NOT;
{IF} 					return IF;
{ELSE} 					return ELSE;
{WHILE} 				return WHILE;
{DO} 					return DO;
{THEN} 					return THEN;
{END_IF} 				return END_IF;
{TRUE} 					return TRUE;
{FALSE} 				return FALSE;
{ASSIGN} 				return ASSIGN;
{PRINT}					return PRINT;
{TRADUCIR}				return TRADUCIR;
{NEW_LINE}				return NEW_LINE;
{VARIABLE} 				{yylval.string = yytext; return VARIABLE;}
[\n]  					{ yylineno++; ;}
[ \t]                   ;
.						;
%%
