%{
	#include <stdio.h>
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

%token TEXT
%token NUMBER

%token <string> STRING
%token <number> INTEGER
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

%right ASSIGN
%left PLUS MINUS
%left MULTIPLY DIVIDE

%type<string> definition
%type<number> type
%type<string> var
%type<string> expr

%start init

/* type: 0 es int, 1 es string, 2 es braille */
%%

init: 
	start program end
	;

start:
	START {printf("#include <stdio.h> \n#include <stdlib.h> \n#include \"list.h\" \n#include \"stdio.h\" \n#include \"string.h\" \n\n");printf("int main(){ \n");}
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
	;

conditional:
	if_def open_op boolean_exp close_op then_def program END_IF {printf("}\n");}
	| if_def open_op boolean_exp close_op then_def program else_def program END_IF {printf("}\n");}
	| do_def program while_def open_op boolean_exp close_op delimiter_end {printf("\n");}
	;

boolean_exp:
	expr operator expr
	| boolean_exp and_op boolean_exp
	| boolean_exp or_op boolean_exp
	| not_op boolean_exp
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
	definition assign_op expr
	| definition assign_op str
	| var assign_op expr
	| var assign_op str
	;

printing:
	PRINT STRING {printf("printf(%s)", $2);}
	| PRINT VARIABLE {printf("printf(%s)", $2);}
	;

expr:
	var op_sign expr
	| var {$$ = $1;}
	| int op_sign expr {$$ = "$1";}
	| int {$$ = "$1";}
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
	THEN {printf(" {");}
	;

else_def:
	ELSE {printf("}\n else {");}
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
	/* | BRAILLE {$$ = 2; printf("char *");} */
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
%%

void yyerror(char *msg) {
	fprintf(stderr, "%s at line number %d\n\n", msg, yylineno);
  	exit(1);
}

int main() {
  	yyparse();
	return 0;
}