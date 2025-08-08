#include <stdio.h>
#define var int
#define and &&
#define or ||
#define not !

int read(){
    int n;
    scanf("%d", &n);
    return n;
}

void print(int n){
    printf("%d\n", n);
}

int main(){
    #include "fatorial.mc"
}