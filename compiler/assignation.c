/*
#include <stdio.h>
#include <stdlib.h>
#include "assignation.h"


typedef struct assignation_node {
    int type;
    int line_no;

    node_t* (*process)(node_t* node);
    void (*destroy)(node_t* node);

    char* var_name;
    node_t* value;

} assignation_node_t;

static node_t* assignation_process(node_t* node) {
    assignation_node_t* assignation = (assignation_node_t*)node;
    
    var_t* var = variables_hash_map_get(assignation->var_name);

    if (var == NULL) {
        handle_error("variable not declared prior to assignation",node->line_no);
    }

    switch (var->type) {
        case CREATE_VARIABLE_INT:
            var->value.num = ast_int_value_get(assignation->value);
            break;
        case CREATE_VARIABLE_STRING:
            var->value.str = ast_string_value_get(assignation->value);
            break;
        default:
            break;
    }

    return NULL;
}

static void assignation_destroy(node_t* node){
    assignation_node_t* assignation_node = (assignation_node_t*)node;
    free_node(assignation_node->value);
    free(assignation_node);
}

node_t* create_assignation_node(char* var_name, node_t* value, int line_no) {
    assignation_node_t* assignation_node = malloc(sizeof(*assignation_node));
    if(assignation_node==NULL){
        handle_os_error("malloc failed");
    }

    assignation_node->type = ASSIGNATION_TK;
    assignation_node->line_no = line_no;
    assignation_node->process = assignation_process;
    assignation_node->destroy = assignation_destroy;

    assignation_node->var_name = var_name;
    assignation_node->value = value;

    return (node_t*)assignation_node;
    return NULL;
}
*/