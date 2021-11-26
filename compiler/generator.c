#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "generator.h"

static defined_variable variables[MAX_VARIABLES];

typedef char *(*reducer)(node_t *);

reducer reducers[] = {
    reduce_string_node,
    reduce_variable_node,
    reduce_print_node,
    //reduce_operation_node,
    //reduce_block_node,
    //reduce_if_node,
};

void semanticError(char *msg1, char* msg2) {
	fprintf(stderr, "%s%s\n\n", msg1, msg2);
  	exit(1);
}

char *reduce_string_node(node_t *node){
    char *value = ((string_node *)node)->string;

    const size_t bufferLen = strlen(value) + 1;
    char *buffer = malloc(bufferLen);
    snprintf(buffer, bufferLen, "%s", value);

    return buffer;
}

char *reduce_variable_node(node_t *node){
    char *name = ((variable_node *)node)->name;
    char *punctuationLen = "_";
    char *newVariable = calloc(strlen(name) + strlen(punctuationLen) + 1, sizeof(char));

    strcpy(newVariable, name);
    strcat(newVariable, "_");

    return newVariable;
}

defined_variable *search_variable(char *variableName){
    int i;

    for (i = 0; variables[i].name[0] != '0' && i < MAX_VARIABLES; i++){
        if (strcmp(variables[i].name, variableName) == 0){
        return &variables[i];
        }
    }
    return NULL;
}

char *reduce_print_node(node_t *node){
    print_node *value_node = (print_node *)node;
    char *expression = eval(value_node->expression);
    char *printfParameter;

    char *p = malloc(strlen(expression) * sizeof(char));
    strcpy(p, expression);
    p[strlen(p) - 1] = 0;

    defined_variable *variable = search_variable(p);

    if(variable == NULL){
        if(expression[0] != '\"' && expression[strlen(expression) - 1] != '\"'){
            semanticError("Error, trying to print a non declared variable or not string: ", p);
        }
        printfParameter = "%s";
    }
    else{
        if (variable->type == STRING_VAR)
            printfParameter = "%s";
        else
            printfParameter = "%d";
    }

    const size_t delimiterLen = strlen("printf('', );\n") + 2; //2 de %s o %d o %f
    const size_t bufferLen = strlen(expression) + delimiterLen + 1;
    char *buffer = calloc(bufferLen, sizeof(char));
    snprintf(buffer, bufferLen, "printf(\"%s\", %s);\n", printfParameter, expression);

    return buffer;
}

// devuelve el reducer si lo hay
static char *eval(node_t *node){
    if (node == NULL || reducers[node->type] == NULL){
        char *emptyString = "";
        return emptyString;
    }

    return reducers[node->type](node);
}

// genera el codigo
char *generate_code(node_t *node){
    for (int i = 0; i < MAX_VARIABLES; i++){
        memset(variables[i].name, '0', MAX_VARIABLE_LENGTH);
    }

    char *code = eval(node);
    return code;
}