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

%token ASSIGN
%token TRANSLATE
%token PRINT
%token PRINT_B
%token DIVIDE_ASSIGN
%token CONTRACTION
%token CREATE_VARIABLE_BRAILLE
%token CREATE_VARIABLE_TEXT
%token IF
%token NEW_LINE

%token INNER_BLOCK_START
%token INNER_BLOCK_END

%token VARIABLE
%token INT
%token STRING

%type <node> assign_operation
%type <node> expression
%type <node> primary_expression
%type <node> constant_expression
%type <node> variable_expression
%type <node> right_expression
%type <node> block
%type <node> print_block

%type <buffer> VARIABLE
%type <buffer> STRING
%type <buffer> INT

%type <lista> inner_block
%type <lista> instructions_list

%parse-param {node_list ** program}

%start instructions_list

%%

primary_expression:
	constant_expression { $$ = $1; }
    | STRING { $$ = string_node_generator($1); }
	;

constant_expression:
	INT { $$ = constant_node_generator($1, INT_CONSTANT); }
	;

variable_expression:
	VARIABLE { $$ = variable_node_generator($1); }
	;

right_expression:
	primary_expression { $$ = $1; }
	| variable_expression { $$ = $1; }
	;

assign_operation:
	right_expression { $$ = $1; }
	| CREATE_VARIABLE_TEXT variable_expression ASSIGN assign_operation { $$ = operation_node_generator($2, $4, "="); }
    ;

expression:
	assign_operation { $$ = $1; }
	;

block:
	inner_block { $$ = block_node_generator($1); }
	| print_block { $$ = $1; }
	| expression  { $$ = instruction_node_generator($1); }
	| NEW_LINE { $$ = empty_node_generator(); }
	;

inner_block:
	INNER_BLOCK_START INNER_BLOCK_END { $$ = instruction_list_generator(NULL); }
	| INNER_BLOCK_START instructions_list INNER_BLOCK_END { $$ = $2; }
	| INNER_BLOCK_START instructions_list INNER_BLOCK_END NEW_LINE{ $$ = $2; }
	;

instructions_list:
	block { $$ = (*program = instruction_list_generator($1)); }
	| instructions_list block { $$ = (*program = add_instruction_generator($1, $2)); }
	;

print_block:
	PRINT expression { $$ = print_node_generator($2); }
	;
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