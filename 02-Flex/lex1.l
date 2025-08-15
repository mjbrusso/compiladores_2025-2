 // Definições
%{
    int nlinhas=0, ncaracteres=0;
%}

%%
    // Regras

\n  { nlinhas++; ncaracteres++;}
.   { ncaracteres++; }  

%%
 // Código
int main(){        
    yylex();
    printf("%d linhas\n%d caracteres\n", nlinhas, ncaracteres);
}
