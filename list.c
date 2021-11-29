#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "list.h"

struct node *first = NULL;
struct node *current = NULL;


void add(char *key, bool is_int, bool is_braille){
    
    struct node *list = (struct node *)malloc(sizeof(struct node));

    int len = strlen(key);
    list->variable_name = (char *)malloc(sizeof(char) * len + 1);
    strcpy((char *)list->variable_name, (char *)key);

    list->is_int = is_int;
    if(is_int){
        list->is_string = false;
        list->is_braille = false;
    }
    else {
        list->is_braille = is_braille;
        list->is_string = !is_braille;

    }

    list->next = first;

    first = list;
}


struct node *find(char *variable_name){
    
    struct node *current = first;

    if (first == NULL){
        return NULL;
    }

    while (strcmp(current->variable_name, variable_name) != 0){
        if (current->next == NULL){
            return NULL;
        } else{
            current = current->next;
        }
    }
    return current;
}