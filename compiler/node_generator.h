#ifndef _NODES_GENERATOR_H
#define _NODES_GENERATOR_H

#define INT_CONSTANT 1

#define TRUE 1
#define FALSE 0

typedef enum{
  STRING_NODE = 0,
  CONSTANT_NODE,
  VARIABLE_NODE,
  OPERATION_NODE,
  CONDITIONAL_NODE,
  BLOCK_NODE,
  EMPTY_NODE,
  IF_NODE,
  WHILE_NODE,
  RETURN_NODE,
  INSTRUCTIONS_NODE,
  INSTRUCTION_NODE,
  NEGATION_NODE,
  PRINT_NODE
} node_type;

typedef struct node_s{
  node_type type;
} node_t;

typedef struct node_list{
  node_type type;
  node_t *node;
  struct node_list *next;
} node_list;

typedef struct variable_node{
  node_type type;
  int declared;
  char *name;
  node_t *stored;
  char *variable;
} variable_node;

typedef struct if_node{
  node_type type;
  node_t *condition;
  node_t *then;
  node_t *otherwise;
} if_node;

typedef struct string_node{
  node_type type;
  char *string;
} string_node;

typedef struct block_node{
  node_type type;
  node_list *instructions;
} block_node;

typedef struct print_node{
  node_type type;
  node_t *expression;
} print_node;

typedef struct constant_node{
  node_type type;
  char *constant;
  int constantType;
} constant_node;

typedef struct operation_node{
  node_type type;
  node_t *first;
  node_t *second;
  char *operator;
} operation_node;

typedef struct instruction_node{
  node_type type;
  node_t *instruction;
} instruction_node;

print_node *print_node_generator(node_t *expression);
string_node *string_node_generator(const char *string);

#endif