#include <stdio.h>
#include <string.h>

char* change_alphabet(char string[],int len);

int main(){
    char string[101];
    
    printf("Enter the string: ");
    scanf("%s",string);

    int len = strlen(string);
    
    char* resString = change_alphabet(string,len);

    printf("\nThe new string is: ");
    printf("%s",resString);

    return 0;
}