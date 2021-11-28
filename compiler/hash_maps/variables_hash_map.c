#include "variables_hash_map.h"
#include "khash.h"

KHASH_MAP_INIT_STR(variables_hash_map, var_t*)

static khash_t(variables_hash_map) * variables_hm;

static var_t * create_new_var(char* var_name, int type);

void init_variables_hash_map(void) {
    variables_hm = kh_init(variables_hash_map);
}

void free_variables_hash_map(void) {
    var_t* var;
    kh_foreach_value(variables_hm, var, free(var));
    kh_destroy(variables_hash_map, variables_hm);
}

var_t* variables_hash_map_put(char* var_name, int type) {
    if (!variables_hash_map_exists(var_name)) {

        var_t* new_var = create_new_var(var_name, type);

        int ret;
        khiter_t k = kh_put(variables_hash_map, variables_hm, var_name, &ret);

        if (ret == -1) {
            return NULL;
        }

        kh_val(variables_hm, k) = new_var;

        return new_var;
    }
    
    return NULL;
}

bool variables_hash_map_exists(char* var_name) {
    khiter_t k = kh_get(variables_hash_map, variables_hm, var_name);

    return k != kh_end(variables_hm);
}

static var_t* create_new_var(char* var_name, int type) {
    var_t* new_var = malloc(sizeof(*new_var));

    new_var->type = type;
    new_var->name = var_name;

    return new_var;
}

var_t* variables_hash_map_get(char* var_name) {
    khiter_t k = kh_get(variables_hash_map, variables_hm, var_name);

    if (k != kh_end(variables_hm)) {
        return kh_val(variables_hm, k);
    }

    return NULL;
}
