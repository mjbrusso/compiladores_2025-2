    // Definições
%%
    // Regras

[A-Za-zÀ-ÿ]+   { printf("%s\n", yytext); };
\n      ;
.       ;

%%
    // Código 
int main(){        
    yylex();
}
