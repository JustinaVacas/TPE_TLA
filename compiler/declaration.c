#include "node.h"

#include <stdio.h>
#include <stdlib.h>

#include "error_handler/error_handler.h"
#include "hash_maps/variables_hash_map.h"

static node_t* declaration_process(node_t* node) {
    declaration_node_t* declaration = (declaration_node_t*)node;

    var_t* var = variables_hash_map_put(declaration->var_name, declaration->value_type);

    if (var == NULL) {
        handle_error("redeclaration of variable",node->line_no);
    }
    
    return NULL;
}

static void declaration_destroy(node_t* node) {
    declaration_node_t* declaration = (declaration_node_t*)node;
    free(declaration);
}

node_t* create_declaration_node(int type, char* var_name, int line_no) {
    declaration_node_t * declaration_node = malloc(sizeof(*declaration_node));
    if (declaration_node == NULL) {
        handle_os_error("malloc failed");
    }

    declaration_node->type = DECLARATION;
    declaration_node->line_no = line_no;
    declaration_node->process = declaration_process;
    declaration_node->destroy = declaration_destroy;

    declaration_node->value_type = type;
    declaration_node->var_name = var_name;

    return (node_t*)declaration_node;
}
