#include "node.h"
#include <stdio.h>

node_t* execute_node(node_t* node){
    if(node==NULL){
        return NULL;
    }

    return node->process(node);
}

void execute(node_t* ast) {
    execute_node(ast);
}

void free_ast(node_t* node) {
    free_node(node);
}

void free_node(node_t* node) {
    if (node == NULL) {
        return;
    }
    node->destroy(node);
}