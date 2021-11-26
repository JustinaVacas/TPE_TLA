#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "generator.h"

static defined_variable variables[MAX_VARIABLES];

typedef char *(*reducer)(node_t *);

reducer reducers[] = {
    reduce_string_node,
    reduce_variable_node,
    //reduce_operation_node,
    //reduce_block_node,
    //reduce_if_node,
    //reduce_print_node
};

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