#include "node.h"

#include <stdio.h>
#include <stdlib.h>

#include "error_handler/error_handler.h"

static node_t* blocks_process(node_t* node) {
    execute_node(node->left);
    return execute_node(node->right);
}

static void blocks_destroy(node_t * node) {
    free_node(node->left);
    free_node(node->right);

    free(node);
}

node_t* create_blocks_node(node_t* left, node_t* right, int line_no) {
    node_t* blocks_node = malloc(sizeof(*blocks_node));
    if (blocks_node == NULL) {
        handle_os_error("malloc failed");
    }

    blocks_node->type = BLOCKS;
    blocks_node->line_no = line_no;
    blocks_node->process = blocks_process;
    blocks_node->destroy = blocks_destroy;

    blocks_node->left = left;
    blocks_node->right = right;

    return blocks_node;
}
