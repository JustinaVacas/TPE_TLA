#ifndef _NODE_H_
#define _NODE_H_

struct node;

typedef struct node {
    int type;
    int line_no; //?
    struct node* (*process)(struct node* node);
    void (*destroy)(struct node* node);

    struct node* left;
    struct node* right;
} node_t;


#endif
