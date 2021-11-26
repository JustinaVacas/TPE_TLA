#ifndef _GENERATOR_H
#define _GENERATOR_H

#include "node_generator.h"

#define MAX_VARIABLES 30
#define MAX_VARIABLE_LENGTH 64

typedef enum{
  STRING_VAR = 0,
  INT_VAR,
} variable_type;

typedef struct defined_variable{
    variable_type type;
    char name[MAX_VARIABLE_LENGTH];
    int defined;
} defined_variable;

char *reduce_string_node(node_t *node);
char *reduce_variable_node(node_t *node);
static char *eval(node_t *node);
char *generate_code(node_t *node);

#endif