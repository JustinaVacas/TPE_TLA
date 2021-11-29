#ifndef LIST_H
#define LIST_H

#include <stdbool.h>

struct node{
    char * variable_name;
    bool is_braille;
    bool is_string;
    bool is_int;
    struct node *next;
};

void add(char *key, bool is_int, bool is_braille);
struct node * find(char *variable_name);

#endif