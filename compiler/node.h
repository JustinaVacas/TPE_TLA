#ifndef _NODE_H
#define _NODE_H

struct node;

typedef struct node {
    int type;
    int line_no; //?

    struct node* (*process)(struct node* node);
    void (*destroy)(struct node* node);

    struct node* left;
    struct node* right;
} node_t;

typedef struct declaration_node {
    int type;
    int line_no;

    node_t* (*process)(node_t* node);
    void (*destroy)(node_t* node);

    int value_type;
    char* var_name;
} declaration_node_t;

typedef enum{
    BLOCKS,
    DECLARATION,
    DEFINITION,
    ASSIGNATION
} node_type;

typedef enum{
  INT_TYPE,
  STRING_TYPE,
} value_type;

// NODE
void execute_n(node_t* node);
node_t * execute_node(node_t* node);
void free_n(node_t* node);
void free_node(node_t* node);
#endif
