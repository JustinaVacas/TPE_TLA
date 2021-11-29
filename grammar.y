/* ESTRUCTURA

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
	#include <stdlib.h>
	#include "list.h"
	extern int yylineno;
	int yylex();
	void yyerror(char* msg);
%}

%union {
 	int integer;
	char * node;
	char * string;
	char * braille;
	char * variable;
}

/* En la parte de definiciones se define los token, todos los terminales
con start marcamos el distinguido */ 

/* Bata Type */
%token <variable> VARIABLE_STRING 
%token <variable> VARIABLE_INT
%token <variable> VARIABLE_BRAILLE
%token <integer> INT
%token <string> STRING
%token <braille> BRAILLE
%token CREATE_VARIABLE_STRING
%token CREATE_VARIABLE_BRAILLE
%token CREATE_VARIABLE_INT
%token START
%token END

/* Functions */
%token TRANSLATE
%token PRINT
%token PRINT_B
%token CONTRACTION

/* Blocks */
%token ASSIGN

/* Conditional */
%token IF 
%token THEN  
%token DO 
%token WHILE

/* Relational operators */
%token '-' 
%token '+' 
%token '*' 
%token '/' 
%token '<' 
%token '>'
%token '('
%token ')' 
%token '{'
%token '}' 
%token EQ 
%token LE 
%token GE 
%token NEQ

/* Logical operators */
%token AND 
%token OR 

%type <node> program
%type <node> blocks
%type <node> block

%type <node> assign_tk

%type <node> expression_int
%type <node> expression_string
%type <node> expression_braille

%type <node> relationals_int
%type <node> relationals_string
%type <node> relationals_braille

%type <node> variable_string
%type <node> variable_int
%type <node> variable_braille

%type <node> if_int
%type <node> if_string
%type <node> if_braille

%type <node> print
%type <node> printb
%type <node> traducir
%type <node> contraer
%type <node> string
%type <node> do_while
%type <node> num
%type <node> assign
%type <node> declaration
%type <node> definition
%type <node> start
%type <node> end

%right ASSIGN
%left OR AND
%left '>' '<' LE GE EQ NEQ
%left '+' '-'
%left '*' '/' '%'
%left ')'
%right '('

%start init

%%

/* braille aux
program --> blocks --> blocks block --> blocks block block
block --> assign --> texto variable es expression_string 
--> texto aux es string --> texto aux es "hola"
block --> if_int --> si relationals_int entonces block --> si exp_int EQ expresion_int entonces assign
int aux1 = 1
int aux2 = 2
int aux3 = 4
aux3 = aux1 + aux2 
*/

init: 
	start program end
	;

start:
	START {printf("#include <stdio.h> \n#include <stdlib.h> \n#include \"list.h\" \n#include \"stdio.h\" \n#include \"string.h\" \n\n"); 
		printf("int main(){ \n");}
	;

end:
	END {printf("return 0;}");}
	;

program: 
	blocks
	;

blocks:
	blocks block 
	| { printf(";\n");}
	;

block:
	definition {}
	| declaration {}
	| assign {}
	| traducir {}
	| print {}
	| printb {}
	| contraer {}
	| if_int {}
	| if_string {}
	| if_braille {}
	| do_while {}
	;
	
expression_int:
	expression_int '+' expression_int {}
	| expression_int '-' expression_int {}
	| expression_int '*' expression_int {}
	| expression_int '/' expression_int {}
	| expression_int '%' expression_int {}
	| '(' expression_int ')' {}
	| variable_int {}
	| num {$$ = $1;}
	; 


variable_int:
	VARIABLE_INT { struct node * aux = find($1); if(aux != NULL && aux->is_int){printf("%s", $1);} else{ yyerror("no existe la variable o no es int");}}
	;
	
variable_string:
	VARIABLE_STRING { struct node * aux = find($1); if(aux != NULL && aux->is_string){printf("%s",$1);} else{ yyerror("no existe la variable o no es string");}}
	;

variable_braille:
	VARIABLE_BRAILLE {  struct node * aux = find($1); if(aux != NULL && aux->is_braille){printf("%s",$1);} else{ yyerror("no existe la variable o no es braille");}}
	;

relationals_int:
	expression_int '>' expression_int {}
	| expression_int '<' expression_int {}
	| expression_int GE expression_int {}
	| expression_int NEQ expression_int {}
	| expression_int LE expression_int {}
	| expression_int OR expression_int {}
	| expression_int AND expression_int {}
	| expression_int EQ expression_int {}
	;

expression_string:
	expression_string '+' expression_string {}
	| variable_string {}
	| string {}
	; 

relationals_string:
	expression_string '>' expression_string {}
	| expression_string '<' expression_string {}
	| expression_string GE expression_string {}
	| expression_string NEQ expression_string {}
	| expression_string LE expression_string {}
	| expression_string OR expression_string {}
	| expression_string AND expression_string {}
	| expression_string EQ expression_string {}
	;

expression_braille:
	expression_braille '+' expression_braille {}
	| variable_braille {}
	| braille {}
	; 

relationals_braille:
	expression_braille '>' expression_braille {}
	| expression_braille '<' expression_braille {}
	| expression_braille GE expression_braille {}
	| expression_braille NEQ expression_braille {}
	| expression_braille LE expression_braille {}
	| expression_braille OR expression_braille {}
	| expression_braille AND expression_braille {}
	| expression_braille EQ expression_braille {}
	;

num:
	INT {printf("%d",$1);} 
	;

string:
	STRING {printf("%s",$1);}
	;

braille:
	BRAILLE {printf("%s",$1);}

if_int:
	IF relationals_int THEN '{' blocks '}' {}
	;

if_string:
	IF relationals_string THEN '{' blocks '}' {}
	;

if_braille:
	IF relationals_braille THEN '{' blocks '}' {}
	;

traducir:
	TRANSLATE variable_string {}
	| TRANSLATE variable_braille {}
	;
	
print:
	PRINT variable_int {}
	| PRINT variable_string {}
	| PRINT variable_braille {}
	| PRINT num {}
	| PRINT string {}
	;

printb:
	PRINT_B variable_int {}
	| PRINT_B variable_string {}
	| PRINT_B variable_braille {}
	| PRINT_B num {}
	| PRINT_B string {}
	;

contraer:
	CONTRACTION variable_braille {}
	;

do_while:
	DO block WHILE relationals_int {}
	;

// texto aux
declaration:
	CREATE_VARIABLE_INT variable_int { printf("int "); if(find($2) == NULL){add($2,true, false);} else{yyerror("ya existe la variable");}}
	| CREATE_VARIABLE_STRING variable_string { printf("char * "); if(find($2) == NULL){add($2,false, false);} else{yyerror("ya existe la variable");}}
	| CREATE_VARIABLE_BRAILLE variable_braille { printf("char * "); if(find($2) == NULL){add($2,false, true);} else{yyerror("ya existe la variable");} }
	;

assign:
	variable_int assign_tk expression_int {}
	| variable_string assign_tk expression_string {}
	| variable_braille assign_tk expression_braille {}
	;

assign_tk: 
	ASSIGN {printf(" = ");}
	;

// texo aux2 es joji	
definition:
	CREATE_VARIABLE_INT variable_int assign_tk expression_int { printf("int "); if(find($2) == NULL){add($2,true, false);} else{yyerror("ya existe la variable");}}
	| CREATE_VARIABLE_STRING variable_string assign_tk expression_string { printf("char * "); if(find($2) == NULL){add($2,false, false);} else{yyerror("ya existe la variable");}}
	| CREATE_VARIABLE_BRAILLE variable_braille assign_tk expression_braille {  printf("char * "); if(find($2) == NULL){add($2,false, true);} else{yyerror("ya existe la variable");}} 
	;
	
/* 
text aux es "joji"
	aux = joji
                                     --> distinguirlos
	texto aux2 es "b245.34.245.10"
	aux = 245.34.245.10
	text hola es "justi" 


	text aux es 1

	braille aux es 1000000
*/

%%

void yyerror(char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}

int main() {
  	yyparse();
	return 0;
}

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