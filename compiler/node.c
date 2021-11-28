#include <stdio.h>
#include "node.h"

node_t* execute_node(node_t* node){
    if(node==NULL){
        return NULL;
    }

    return node->process(node);
}

void execute_n(node_t* node) {
    execute_node(node);
}

void free_n(node_t* node) {
    free_node(node);
}

void free_node(node_t* node) {
    if (node == NULL) {
        return;
    }
    node->destroy(node);
}