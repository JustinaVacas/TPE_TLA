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

constant_node *constant_node_generator(const char *constant, int constantType){
    constant_node *node = malloc(sizeof(constant_node));
    node->type = CONSTANT_NODE;
    node->constant = calloc(strlen(constant) + 1, sizeof(char));
    node->constantType = constantType;
    strcpy(node->constant, constant);
    return node;
}

block_node *block_node_generator(const node_list *instructions){
    block_node *node = malloc(sizeof(block_node));
    node->type = BLOCK_NODE;
    node->instructions = (node_list *)instructions;
    return node;
}

node_list *instruction_list_generator(const node_t *node){
    node_list *list = malloc(sizeof(node_list));
    list->type = INSTRUCTIONS_NODE;
    list->node = node;
    list->next = NULL;
    return list;
}

node_list *add_instruction_generator(const node_list *list, const node_t *node){
    node_list *actualNode = (node_list *)list;
    while (actualNode->next != NULL)
        actualNode = actualNode->next;
    actualNode->next = instruction_list_generator(node);

    return (node_list *)list;
}

node_t *empty_node_generator(){
    node_t *node = malloc(sizeof(node_t));
    node->type = EMPTY_NODE;
    return node;
}

operation_node *operation_node_generator(const node_t *first, const node_t *second, const char *operator){
    operation_node *node = malloc(sizeof(operation_node));
    node->type = OPERATION_NODE;
    node->first = first;
    node->second = second;
    node->operator = calloc(strlen(operator) + 1, sizeof(char));
    strcpy(node->operator, operator);
    return node;
}

instruction_node *instruction_node_generator(node_t *instruction){
    instruction_node *node = malloc(sizeof(instruction_node));
    node->type = INSTRUCTION_NODE;
    node->instruction = instruction;
    return node;
}

variable_node *variable_node_generator(const char *variable){
    variable_node *node = malloc(sizeof(variable_node));
    node->type = VARIABLE_NODE;
    node->stored = NULL;
    node->declared = FALSE;
    node->name = calloc(strlen(variable) + 1, sizeof(char));
    strcpy(node->name, variable);
    return node;
}