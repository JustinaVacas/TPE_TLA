#include "braille.h"
#include "list.h"

#define ALPH 26
#define NUMS 10

char * brailles[ALPH] = {"⠁","⠃","⠉","⠙","⠑","⠋","⠛","⠓","⠊","⠚","⠅","⠇","⠍","⠝","⠕","⠏","⠟","⠗","⠎","⠞","⠥","⠧","⠺","⠭","⠽","⠵"};
char * brailles_num[NUMS] = {"⠴","⠂","⠆","⠒","⠲","⠢","⠖","⠶","⠦","⠔"};


int braille_123[NUMS] = { 245, 1, 12, 14, 145, 15, 124, 1245, 125, 24};
int braille_ABC[ALPH] = { 1, 12, 14, 145, 15, 124, 1245, 125, 24, 245, 13, 123, 134, 1345, 135, 1234, 12345, 1235, 234, 2345, 136, 1236, 246, 1346, 1346, 1356};

int itoa(int val, char* buf);

char* bra_ABC_to_text(char* braille){
    char buf[150];
    strcpy(buf, braille);
    char * ans = calloc(strlen(braille), sizeof(char));
    int k = 0;

    char* token = strtok(buf, ".");
    while(token != NULL) {
        int j;
        for(j = 0; j < 26; j++){
            if(atoi(token) == braille_ABC[j]){
                ans[k++] = j  + 'a';
                break;
            } 
        }
        if(j == 26){
            printf("Está mal escrito\n");
            break;
        }
        token = strtok(0, ".");
    }
    return ans;
}

char* text_to_bra_ABC(char* text){
    char * ans = calloc(strlen(text)*6, sizeof(char));
    int k = 0;
    for (int i = 0; i < strlen(text); i++) {
            char buff[10] = {0};
            if(text[i] == ' '){
                continue;
            } else if(text[i] >= '0' && text[i] <= '9'){
                itoa(braille_123[text[i] - '0'], buff);
                for(int i = 0; i < strlen(buff); i++){
                    ans[k++] = buff[i];
                }
            }
            else {
                itoa(braille_ABC[tolower(text[i]) - 'a'], buff);
                for(int i = 0; i < strlen(buff); i++){
                    ans[k++] = buff[i];
                }
            }
            ans[k++] = '.';
        }
        ans[k-1] = '\0';
    return ans;
}

char ** text_to_points(char* text, int * size){
    char ** ans = calloc(strlen(text), sizeof(char*));
    int k = 0;
    for (int i = 0; i < strlen(text); i++) {
        if(text[i] == ' '){
            ans[k++] = " ";
        } else if(text[i] >= '0' && text[i] <= '9'){
            ans[k++] = brailles_num[text[i] - '0'];
        }
        else {
            ans[k++] = brailles[tolower(text[i]) - 'a'];
        }
    }
    *size = k;
    return ans;
}

void print_traduce(char * stdin_braille){
    
    printf("Braille: %s\n", stdin_braille);
    printf("Palabra: ");
    printf("%s", bra_ABC_to_text(stdin_braille));
}

void print_braille(char* text){
    printf("Texto original: %s\n", text);
    printf("Braille: ");
    int size = 0;
    char ** aux = text_to_points(text, &size);
    for (int i = 0; i < size; i++){
        printf("%s", aux[i]);
    }
}


void prt_braille(char * braille){
    int size = 0;
    char ** aux = text_to_points(traduce(braille, 2), &size);
    for (int i = 0; i < size; i++){
        printf("%s", aux[i]);
    }
}

void prt_text(char* braille){
    printf("%s", traduce(braille, 2));
}

void print_braille_num(int numero){
    char * str = malloc(50); 
    itoa(numero, str);
    print_braille(str);
}

void read_and_traduce(){
    printf("Ingresa el texto para traducir a braille: ");
    char * str = malloc(50);
    scanf(" %49[^\n]", str); 
    print_braille(str);
    free(str);
}

//return the length of result string. support only 10 radix for easy use and better performance
int itoa(int val, char* buf){

    const unsigned int radix = 10;

    char* p;
    unsigned int a;        //every digit
    int len;
    char* b;            //start of the digit char
    char temp;
    unsigned int u;

    p = buf;

    if (val < 0){
        *p++ = '-';
        val = 0 - val;
    }

    u = (unsigned int)val;
    b = p;

    do{
        a = u % radix;
        u /= radix;

        *p++ = a + '0';

    } while (u > 0);

    len = (int)(p - buf);

    *p-- = 0;

    //swap
    do{
        temp = *p;
        *p = *b;
        *b = temp;
        --p;
        ++b;

    } while (b < p);

    return len;
}

//hola, chau, buen dia,

void braille_to_text(){
    printf("Ingresa el braille para traducir a texto: "); //123.234.45.1 
    char * str = malloc(50);
    scanf(" %49[^\n]", str); 
    print_traduce(str);
    free(str);
}

char* traduce(char * variable_name, int type){

    if(type == 2) { //si es braille
        return bra_ABC_to_text(variable_name);  
    } else {
        return text_to_bra_ABC(variable_name);
    }
}

char * concat(char * var1, int type1, char * var2, int type2){
    if(type1 == type2){
        size_t len1 = strlen(var1), len2 = strlen(var2);
        char *ans = (char*) malloc(len1 + len2 + 1);
        memcpy(ans, var1, len1);
        memcpy(ans + len1, var2, len2+1);
        return ans;
    } else{
        char * trad = traduce(var2, type2);
        size_t len1 = strlen(var1), len2 = strlen(trad);
        char *ans = (char*) malloc(len1 + len2 + 1);
        memcpy(ans, var1, len1);
        memcpy(ans + len1, trad, len2+1);
        return ans;
    }
}

