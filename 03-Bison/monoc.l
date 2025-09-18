%{
#include <stdio.h>
#include <stdlib.h>
#include "monoc.tab.h"
#include "symtab.h"

Symtab* ts; // tabela de simbolos
%}

%option yylineno

%%

"//".*                     ; /* Ignora comentários de linha */ 
[ \t\n]                    ; /* Ignora espaços em branco, tabulações e quebras de linha */
";"                        { return SEMICOLON; }
"print"                    { return PRINT; }
"("                        { return LPAREN; }
")"                        { return RPAREN; }

[0-9]+                     { yylval = atoi(yytext); return INTLITERAL;  }
"+"                        { return PLUS; }
"-"                        { return MINUS; }
"*"                        { return TIMES; }
"/"                        { return DIVIDE; }
"var"                      { return VARDEF; }
"read"                     { return READ; }
"="                        { return ATTRIB; }
"if"                       { return IF; }
"else"                     { return ELSE; }
"while"                    { return WHILE; }
"break"                    { return BREAK; }
"and"                      { return AND; }
"or"                       { return OR; }
"not"                      { return NOT; }
"=="                       { return EQUAL; }
"!="                       { return NOTEQ; }
"<="                       { return LE; }
">="                       { return GE; }
"<"                        { return LT; }
">"                        { return GT; }
"{"                        { return LBRACE; }
"}"                        { return RBRACE; }
","                        { return COMMA; }
[A-Za-z][A-Za-z0-9_]*      { yylval = yytext; return IDENT;  }

.                          {
                              fprintf(stderr, "Error: '%s' is not recognized (line %d)\n", yytext, yylineno);
                              exit(1);
                           }
%%


int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input file>\n", argv[0]);
        return 1;
    }

    FILE* input = fopen(argv[1], "r");
    if (input == NULL) {
        fprintf(stderr, "Error: could not open file %s\n", argv[1]);
        return 1;
    }
    yyin = input;
    yyparse();
    fclose(input);
    return 0;
}

