#ifndef _NODES_GENERATOR_H
#define _NODES_GENERATOR_H

typedef enum{
  STRING_NODE = 0,
  VARIABLE_NODE,
  OPERATION_NODE,
  BLOCK_NODE,
  IF_NODE,
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

print_node *print_node_generator(node_t *expression);
string_node *string_node_generator(const char *string);

#endif