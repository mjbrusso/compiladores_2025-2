
%%

"//".*  ;
"var"   { printf("(VARDEF, \"%s\")\n", yytext); }
[0-9]+  { printf("(INTLITERAL, \"%s\")\n", yytext);}
\n      ;
.       ;

%%

int main(int argc, char **argv){
    if(argc!=2){
        printf("Error: No input file\n");
        return 1;
    }
    FILE *arq = fopen(argv[1], "r");
    if(arq==NULL){
        printf("Error opening file\n");
        return 2; 
    }
    yyin = arq;
    yylex();
    fclose(arq);
    return 0;
}