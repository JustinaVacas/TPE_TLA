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
	#include "./node_generator.h"
	#include "./generator.h"
	extern int yylineno;
	void yyerror(node_list **, char *);
	void smerror(char * msg);
	static int hasReturn = 0;
%}

%union {
 	char buffer[1000];
 	node_t * node;
	node_list * lista;
}

/* En la parte de definiciones se define los token, todos los terminales
con start marcamos el distinguido */ 

/* data type */
%token VARIABLE
%token INT_BRAILLE
%token INT_TEXT
%token STRING_BRAILLE
%token STRING_TEXT
%token CREATE_VARIABLE_BRAILLE
%token CREATE_VARIABLE_TEXT

/* Functions */
%token TRANSLATE
%token PRINT
%token PRINT_B
%token CONTRACTION

/* Blocks*/
%token ASSIGN
%token DIVIDE_ASSIGN

/* Conditional*/
%token IF 
%token ELSE
%token THEN  

/*Relational operators*/
%token '-' 
%token '+' 
%token '*' 
%token '/' 
%token '<' 
%token '>'
%token '('
%token ')' 
%token EQ 
%token LE 
%token GE 
%token NEQ

/*Logical operators*/
%token AND 
%token OR 

%token NEW_LINE

%token INNER_BLOCK_START
%token INNER_BLOCK_END

%type <node> program
%type <node> blocks
%type <node> block
%type <node> expression_int
%type <node> expression_string
%type <node> relationals_int
%type <node> relationals_string
%type <node> variable
%type <node> string
%type <node> num
%type <node> assign_int
%type <node> assign_string

%type <buffer> VARIABLE
%type <buffer> STRING_BRAILLE STRING_TEXT
%type <buffer> INT_BRAILLE INT_TEXT

%type <token> CREATE_VARIABLE_BRAILLE
%type <token> CREATE_VARIABLE_TEXT


%parse-param {node_list ** program}

%start program

%%
/* braille aux
program --> blocks --> blocks block --> blocks block block
*/
program: 
	blocks {$$ = $1;}
	;

blocks:
	block {}
	| blocks block {
		// create_node();
	}
	;

block:
	expression_int {}
	| expression_string {}
	| assign_int {}
	| assign_string {}
	| if_int {}
	| if_string {}
	;
	
expression_int:
	expression_int '+' expression_int {}
	| expression_int '-' expression_int {}
	| expression_int '*' expression_int {}
	| expression_int '/' expression_int {}
	| expression_int '%' expression_int {}
	| '(' expression_int ')' {}
	| variable {$$ = $1;}
	| num {$$ = $1;}
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
	| variable {$$ = $1;}
	| string {$$ = $1;}
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

variable:
	VARIABLE {}
	;

num:
	INT_TEXT 
	// { $$ = create_int_text_node($1); }
	| INT_BRAILLE {}
	;

string:
	STRING_TEXT 
	// { $$ = create_string_text_node($1); }
	| STRING_BRAILLE {}
	;

if_int:
	IF relationals_int THEN block {}
	| IF relationals_int THEN block ELSE block {}
	;

if_string:
	IF relationals_string THEN block {}
	| IF relationals_string THEN block ELSE block {}
	;

assign_int:
	CREATE_VARIABLE_BRAILLE variable ASSIGN INT_BRAILLE {}
	| CREATE_VARIABLE_TEXT variable ASSIGN INT_TEXT {}
	;
	
assign_string:
	CREATE_VARIABLE_BRAILLE variable ASSIGN STRING_BRAILLE {}
	| CREATE_VARIABLE_TEXT variable ASSIGN STRING_TEXT {}
	;

 

/* 

text aux es "joji"
	aux = joji
                                     --> distinguirlos
	braille aux2 es 245.34.245.10
	aux = 245.34.245.10
	text hola es "justi" 


	text aux es 1

	braille aux es 1000000
*/

%%

void yyerror(node_list ** program, char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}
void smerror(char *msg) {
	fprintf(stderr, "%s\n", msg);
  	exit(1);
}
int main() {
	node_list * program;
  	int ret = yyparse(&program);
	if (ret == 1) {
		fprintf(stderr, "%s", "Error parsing program.\n\n");
		return 1;
	} else if (ret == 2) {
		fprintf(stderr, "%s", "Error run out of memory.\n\n");
	}
	
	printf("#include <stdio.h>\n");
	printf("#include <stdlib.h>\n\n");
	printf("int main(int argc, char const *argv[])\n{\n");
	printf("%s\n", generate_code(program));
	if(!hasReturn){
		printf("\nreturn 0;\n");
	}
	printf("}");

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