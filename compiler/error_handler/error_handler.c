#include "error_handler.h"

#include <stdio.h>
#include <stdlib.h>

//#include "compiler_utils/yacc_utils/yacc_utils.h"

void handle_error(char* message, int line_no){
    fprintf(stderr, "Error in line %d: %s\n", line_no, message);
    //free_resources(1);
    exit(1);
}

void handle_os_error(char* message) {
    fprintf(stderr, "Error: %s\n", message);
    //free_resources(1);
    exit(1);
}
