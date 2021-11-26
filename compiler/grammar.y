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
%}

%union {
 	
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

%type <node> assign_operation

%parse-param {nodeList ** program}

%start instructions_list

%%

primary_expression:
	  constant_expression { $$ = $1; }
      STRING { $$ = string_node_generator($1); }
      PAREN_START expression PAREN_END { $$ = $2; }
	;

assign_operation:
	conditional_operation { $$ = $1; }
        CREATE_VARIABLE_BRAILLE variable_expression ASSIGN assign_operation { $$ = operation_node_generator($2, $4, "="); }
        CREATE_VARIABLE_TEXT variable_expression ASSIGN assign_operation { $$ = operation_node_generator($2, $4, "="); }
        CREATE_VARIABLE variable_expression DIVIDE_ASSIGN assign_operation { $$ = operation_node_generator($2, $4, "/="); }
	;

block:
	inner_block { $$ = block_node_generator($1); }
	if_block { $$ = $1; }
	print_block { $$ = $1; }
	;

print_block:
	PRINT expression { $$ = print_node_generator($2); }
	;

if_block:
	IF expression inner_block { $$ = if_node_generator($2, $3, NULL); }
    IF expression inner_block ELSE inner_block { $$ = if_node_generator($2, $3, $5); }
	;

%%

void yyerror(nodeList ** program, char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}
void smerror(char *msg) {
	fprintf(stderr, "%s\n", msg);
  	exit(1);
}
int main() {
	nodeList * program;
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