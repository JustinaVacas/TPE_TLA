%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "list.h"
	extern int yylineno;
	int yylex();
	void yyerror(char* msg);
%}

%union {
 	int number;
	char * string;
}

%token START
%token END
%token DELIMITER
%token READ_AND_TRADUCE
%token BRAILLE_TO_TEXT
%token TRADUCIR
%token CONCATENAR

%token TEXT
%token NUMBER
%token BRAILLE

%token <string> STRING
%token <number> INTEGER
%token <string> T_BRAILLE
%token <string> VARIABLE

%token MINUS
%token PLUS
%token MULTIPLY
%token DIVIDE

%token LOWER
%token GREATER
%token EQUALS
%token NOT_EQUALS
%token TRUE
%token FALSE

%token AND
%token OR
%token NOT

%token OPEN
%token CLOSE

%token ASSIGN

%token IF
%token ELSE
%token WHILE
%token DO
%token END_IF
%token THEN

%token PRINT
%token NEW_LINE

%right ASSIGN
%left AND OR
%left GREATER LOWER EQUALS NOT_EQUALS
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left NOT

%type<string> definition
%type<number> type
%type<number> traduce
%type<number> concat
%type<string> var

%start init

/* type: 0 es int, 1 es string, 2 es braille */
%%

init: 
	start program end
	;

start:
	START {printf("#include <stdio.h> \n#include <stdlib.h> \n#include \"list.h\" \n#include \"braille.h\" \n#include <string.h> \n\n");printf("int main(){ \n");}
	;

program:
	conditional program
	| instruction program
	| {}
	;

end:
	END {printf("return 0;}");}
	;

instruction:
	definition delimiter_end
	| assignment delimiter_end
	| printing delimiter_end
	| read_and_traduce delimiter_end
	| braille_to_text delimiter_end
	;

conditional:
	if_def open_op boolean_exp close_op then_def program end_if_op
	| if_def open_op boolean_exp close_op then_def program else_def program end_if_op
	| do_def program while_def open_op boolean_exp close_op delimiter_end {printf("\n");}
	;

boolean_exp:
	expr operator expr
	| boolean_exp and_op boolean_exp
	| boolean_exp or_op boolean_exp
	| not_op open_op boolean_exp close_op
	| open_op boolean_exp close_op
	;

operator:
	eq_op | neq_op | lower_op | greater_op ;

definition:
	type VARIABLE {
		if(!find($2)){
			add($2,$1);
		}else {
			fprintf(stderr, "Variable '%s' is already defined.\n",$2);
			yyerror("Variable already taken");
		} printf("%s", $2);
		$$ = $2;
		}
	;

assignment:
	definition assign_op expr {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 0){
			fprintf(stderr, "Variable %s is not type int.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| definition assign_op str {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 1){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| var assign_op expr {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 0){
			fprintf(stderr, "Variable %s is not type int.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| var assign_op str {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 1){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| definition assign_op bra {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 2){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| definition assign_op traduce {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if ($3 == 2 && aux->type != 1){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		} else if ($3 == 1 && aux->type != 2){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| var assign_op traduce {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if ($3 == 2 && aux->type != 1){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		} else if ($3 == 1 && aux->type != 2){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| var assign_op bra {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 2){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| definition assign_op concat {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if ($3 == 2 && aux->type != 2){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		} else if ($3 == 1 && aux->type != 1){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| var assign_op concat {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if ($3 == 2 && aux->type != 2){
			fprintf(stderr, "Variable %s is not type braille.\n", $1);
			yyerror("Variable not exist");
		} else if ($3 == 1 && aux->type != 1){
			fprintf(stderr, "Variable %s is not type string.\n", $1);
			yyerror("Variable not exist");
		};
	}
	;
	;

printing:
	PRINT STRING {printf("printf(%s)", $2);}
	| PRINT INTEGER {printf("printf(\"%%d\", %d)", $2);}
	| PRINT T_BRAILLE {printf("prt_text(%s)", $2);}
	| PRINT VARIABLE {
		struct node * aux = find($2);
		if(aux == NULL){
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $2);
			yyerror("Variable not exist");
		} else if (aux->type == 0){ 
			printf("printf(\"%%d\", %s)", $2);
		} else if (aux->type == 1) {
			printf("printf(%s)", $2);
		} else {
			printf("prt_text(%s)", $2); 
		};
	}
	| PRINT BRAILLE STRING {printf("print_braille(%s)", $3);}
	| PRINT BRAILLE VARIABLE {
		struct node * aux = find($3);
		if(aux == NULL){
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $3);
			yyerror("Variable not exist");
		} else if(aux->type == 1){ 
			printf("print_braille(%s)", $3);
		} else if (aux->type == 0){
			printf("print_braille_num(%s)", $3);
		}else {
			printf("prt_braille(%s)", $3); 
		};
	}
	| PRINT BRAILLE INTEGER {printf("print_braille_num(%d)", $3);}
	| PRINT BRAILLE T_BRAILLE {printf("prt_braille(%s)", $3);}
	| PRINT NEW_LINE {printf("printf(\"\\n\")");}
	;

read_and_traduce:
	READ_AND_TRADUCE {printf("read_and_traduce()");}
	;

braille_to_text:
	BRAILLE_TO_TEXT {printf("braille_to_text()");}
	;

traduce:
	TRADUCIR VARIABLE {
		struct node * aux = find($2);
		if(aux == NULL) {
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $2);
			yyerror("Variable not exist");
		} else if (aux->type == 0){
			fprintf(stderr, "Variable %s is not type string or type braille.\n", $2);
			yyerror("Variable not exist");
		} else {
			printf("traduce(%s, %d)", aux->variable_name, aux->type);
		};
		$$ = aux->type;
	}
	;

concat:
	CONCATENAR VARIABLE VARIABLE {
		struct node * aux1 = find($2);
		struct node * aux2 = find($3);
		if(aux1 == NULL) {
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $2);
			yyerror("Variable not exist");
		} else if(aux2 == NULL) {
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $3);
			yyerror("Variable not exist");
		} else if (aux1->type == 0){
			fprintf(stderr, "Variable %s is not type string or type braille.\n", $2);
			yyerror("Variable not exist");
		} else if (aux2->type == 0){
			fprintf(stderr, "Variable %s is not type string or type braille.\n", $3);
			yyerror("Variable not exist");
		} else {
			printf("concat(%s, %d, %s, %d)", aux1->variable_name, aux1->type, aux2->variable_name, aux2->type);
		};
		$$ = aux1->type;
	}
expr:
	var op_sign expr { 
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 0){
			fprintf(stderr, "Variable %s is not type int.\n", $1);
			yyerror("Variable not exist");
		}; 
	}
	| var {
		struct node * aux = find($1); 
		if(aux == NULL){
			fprintf(stderr, "Variable %s doesn't exist.\n", $1);
			yyerror("Variable not exist"); 
		} else if (aux->type != 0){
			fprintf(stderr, "Variable %s is not type int.\n", $1);
			yyerror("Variable not exist");
		};
	}
	| int op_sign expr
	| int
	| open_op expr close_op op_sign expr
	| open_op expr close_op
	;

op_sign:
	PLUS {printf(" + ");}
	| MINUS {printf(" - ");}
	| MULTIPLY {printf(" * ");}
	| DIVIDE {printf(" / ");}
	;

assign_op:
	ASSIGN {printf(" = ");}
	;

open_op:
	OPEN {printf("(");}
	;

close_op:
	CLOSE {printf(")");}
	;

if_def:
	IF {printf("if ");}
	;

then_def:
	THEN {printf(" {\n");}
	;

else_def:
	ELSE {printf("}\n else {");}
	;

end_if_op:
	END_IF {printf("}\n");}
	;

do_def:
	DO {printf("do { \n");}
	;

while_def:
	WHILE {printf("} while ");}
	;

delimiter_end:
    DELIMITER {printf(";\n");}
	;

or_op:
	OR {printf(" || ");}
	;

and_op:
	AND {printf(" && ");}
	;

not_op: 
	NOT {printf("!");}
	;

lower_op: 
	LOWER {printf("<");}
	;

greater_op: 
	GREATER {printf(">");}
	;

eq_op: 
	EQUALS {printf("==");}
	;

neq_op: 
	NOT_EQUALS {printf("!=");}
	;

type: NUMBER {$$ = 0; printf("int ");} 
	| TEXT {$$ = 1; printf("char *");}
	| BRAILLE {$$ = 2; printf("char *"); }
	; 

var:
	VARIABLE {
		struct node * aux = find($1);
		if(aux != NULL){
			printf("%s", $1);
		} else { 
			fprintf(stderr, "Variable '%s' doesn't exist.\n", $1);
			yyerror("Variable not exist"); };
			$$ = $1;
		}
	;

int: 
	INTEGER {printf("%d", $1);}
	;
str: 
	STRING {printf("%s", $1);}
	;
bra:
	T_BRAILLE {printf("%s", $1);}
%%

void yyerror(char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}

int main() {
  	yyparse();
	return 0;
}