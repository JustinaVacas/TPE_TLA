#include "braille.h"

#define ALPH 26
#define NUMS 10

char * brailles[ALPH] = {"⠁","⠃","⠉","⠙","⠑","⠋","⠛","⠓","⠊","⠚","⠅","⠇","⠍","⠝","⠕","⠏","⠟","⠗","⠎","⠞","⠥","⠧","⠺","⠭","⠽","⠵"};
char * brailles_num[NUMS] = {"⠴","⠂","⠆","⠒","⠲","⠢","⠖","⠶","⠦","⠔"};

int itoa(int val, char* buf);

void print_braille(char* text){
    printf("Texto original: %s\n", text);
    printf("Braille: ");
    for (int i = 0; i < strlen(text); i++) {
        if(text[i] == ' '){
            printf(" ");
        } else if(tolower(text[i]) >= '0' && text[i] <= '9'){
            printf("%s ", brailles_num[text[i] - '0']);
        }
        else {
            printf("%s ", brailles[text[i] - 'a']);
        }
    }
    printf("\n");
}

void print_braille_num(int numero){
    char * str = malloc(50); 
    itoa(numero, str);
    print_braille(str);
}

void read_and_traduce(){
    printf("Ingresa el texto para traducir a braille: ");
    char * str = malloc(50);
    scanf("%49s", str);
    print_braille(str);
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
