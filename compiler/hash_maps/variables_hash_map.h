#ifndef _VARIABLES_HASH_MAP_H
#define _VARIABLES_HASH_MAP_H

#include <stdbool.h>

typedef struct var {
    int type;
    char* name;
    union {
        char* str;
        int num;
    } value;
} var_t;

void init_variables_hash_map(void);

void free_variables_hash_map(void);

var_t* variables_hash_map_put(char* var_name, int type);

bool variables_hash_map_exists(char* var_name);

var_t* variables_hash_map_get(char* var_name);

#endif