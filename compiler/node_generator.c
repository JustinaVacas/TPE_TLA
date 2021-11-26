#include <stdlib.h>
#include <string.h>
#include "node_generator.h"

print_node *print_node_generator(node_t *expression){
    print_node *node = malloc(sizeof(print_node));
    node->type = PRINT_NODE;
    node->expression = expression;
    return node;
}

string_node *string_node_generator(const char *string){
    string_node *node = malloc(sizeof(string_node));
    node->type = STRING_NODE;
    node->string = calloc(strlen(string) + 1, sizeof(char));
    strcpy(node->string, string);
    return node;
}