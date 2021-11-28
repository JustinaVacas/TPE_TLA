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
	#include "./node.h"
	#include "./generator.h"
	extern int yylineno;
	void yyerror(node_t* , char *);
	void smerror(char * msg);
	static int hasReturn = 0;
%}

%union {
 	char buffer[1000];
 	node_t * node;
	char * variable
}

/* En la parte de definiciones se define los token, todos los terminales
con start marcamos el distinguido */ 

/* Bata Type */
%token VARIABLE_STRING
%token VARIABLE_INT
%token INT
%token STRING
%token CREATE_VARIABLE_STRING
%token CREATE_VARIABLE_INT

/* Functions */
%token TRANSLATE
%token PRINT
%token PRINT_B
%token CONTRACTION

/* Blocks */
%token ASSIGN
%token DIVIDE_ASSIGN

/* Conditional */
%token IF 
%token ELSE
%token THEN  
%token DO 
%token WHILE
%nonassoc IF ELSE

/* Relational operators */
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

/* Logical operators */
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
%type <node> print
%type <node> printb
%type <node> traducir
%type <node> contraer
%type <node> variable_int
%type <node> variable_string
%type <node> string
%type <node> do_while
%type <node> num
%type <node> assign
%type <node> declaration
%type <node> definition

%type <buffer> VARIABLE_STRING
%type <buffer> VARIABLE_INT
%type <buffer> STRING
%type <buffer> INT

%type <token> CREATE_VARIABLE_STRING
%type <token> CREATE_VARIABLE_INT

%right '='
%left OR AND
%left '>' '<' LE GE EQ NEQ
%left '+' '-'
%left '*' '/' '%'
%left ')'
%right '('


%parse-param {node_t * code}

%start program

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
program: 
	blocks { code = $1; }
	;

blocks:
	blocks block { $$ = create_blocks_node($1,$2,yylineno);}
	| {
		$$ = NULL;
	}
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
	| do_while {}
	;
	
expression_int:
	expression_int '+' expression_int {}
	| expression_int '-' expression_int {}
	| expression_int '*' expression_int {}
	| expression_int '/' expression_int {}
	| expression_int '%' expression_int {}
	| '(' expression_int ')' {}
	| variable_int {$$ = $1;}
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
	| variable_string {$$ = $1;}
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

variable_int:
	VARIABLE_INT {}
	;

variable_string:
	VARIABLE_STRING {}
	;

num:
	INT {} 
	// { $$ = create_int_text_node($1); }
	;

string:
	STRING {}
	// { $$ = create_string_text_node($1); }
	;

if_int:
	IF relationals_int THEN blocks {}
	| IF relationals_int THEN blocks ELSE blocks {}
	;

if_string:
	IF relationals_string THEN blocks {}
	| IF relationals_string THEN blocks ELSE blocks {}
	;

assign:
	variable_int ASSIGN expression_int 
	// {  $$ = create_assignation_node($1,$3,yylineno);  }
	| variable_string ASSIGN expression_string 
	// { $$ = create_assignation_node($1,$3,yylineno); }
	;

traducir:
	TRANSLATE variable_string {}
	;
	
print:
	PRINT variable_int {}
	| PRINT variable_string {}
	| PRINT num {}
	| PRINT string {}
	;

printb:
	PRINT_B variable_int {}
	| PRINT_B variable_string {}
	| PRINT_B num {}
	| PRINT_B string {}
	;

contraer:
	CONTRACTION variable_string {}
	;

do_while:
	DO block WHILE relationals_int {}
	;
	
declaration:
	CREATE_VARIABLE_INT variable_int { $$ = create_declaration_node(0,$2,yylineno); }
	| CREATE_VARIABLE_STRING variable_string { $$ = create_declaration_node(1,$2,yylineno); }
	// { $$ = create_declaration_node($2,yylineno); }
	;
	
definition:
	CREATE_VARIABLE_INT variable_int ASSIGN expression_int 
	// {  $$ = create_definition_node($2,$4,yylineno); }
	| CREATE_VARIABLE_STRING variable_string ASSIGN expression_string 
	// { $$ = create_definition_node($2,$4,yylineno); }
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

void yyerror(node_t * code, char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}
void smerror(char *msg) {
	fprintf(stderr, "%s\n", msg);
  	exit(1);
}
int main() {
	node_t * code;
  	int ret = yyparse(&code);
	if (ret == 1) {
		fprintf(stderr, "%s", "Error parsing program.\n\n");
		return 1;
	} else if (ret == 2) {
		fprintf(stderr, "%s", "Error run out of memory.\n\n");
	}

	generate_code(code);

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