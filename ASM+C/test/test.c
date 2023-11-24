#include <stdio.h>

char* tost(char string[], int len);

int main(){
    char string[101]="anaaremere";
    int len = 10;


    char* s = tost(string,len);

    printf("%s",s);

    return 0;
}