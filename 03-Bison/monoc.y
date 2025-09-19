%{  /* Declarações */
    #include <stdio.h> // printf, ...
    #include "symtab.h"

    int yylex();                    // Declara função do analizador léxico
    void yyerror(const char* s);    // Declara função para tratamento de erros
    extern int yylineno;            // Variável com o número da linha atual
    extern char *yytext;            // Variável com o texto atual sendo analizado
%}

%union{
    int ival;
    SymtabEntry *sval;
}

 // Tokens, tipos, precedências, etc.

%token PRINT 
%token LPAREN
%token RPAREN
%token SEMICOLON
%token<ival> INTLITERAL
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token VARDEF
%token READ
%token ATTRIB
%token IF
%token ELSE
%token WHILE
%token BREAK
%token AND
%token OR
%token NOT
%token EQUAL
%token NOTEQ
%token LE
%token GE
%token LT
%token GT
%token LBRACE
%token RBRACE
%token COMMA
%token<sval> IDENT

%left PLUS MINUS
%left TIMES DIVIDE

%type <ival> expression
%type <ival> arithmeticOp

%%

    /* Regras sintáticas e ações semanticas */
program:
    program command
    | /* programa vazio */
    ; 

command:
    PRINT LPAREN RPAREN SEMICOLON               { printf("\n"); }
    | PRINT LPAREN expression RPAREN SEMICOLON  { printf("%d\n", $3); }
    | VARDEF IDENT SEMICOLON                    { $2->defined = 1;}
    | VARDEF IDENT ATTRIB expression SEMICOLON  { $2->defined = 1; 
                                                  $2->value = $4; }
    | IDENT ATTRIB expression SEMICOLON         {
                                                if(!$1->defined){
                                                    fprintf(stderr, "%s not defined (line %d)\n", yytext, yylineno);
                                                    exit(1);
                                                }
                                                $1->value = $3; 
                                                }                                              
    ;

expression:
      INTLITERAL            { $$ = $1; }
    | arithmeticOp          { }
    | READ LPAREN RPAREN    { 
                                int n;
                                scanf("%d", &n);
                                $$ = n; 
                            }
    | LPAREN expression RPAREN { $$ = $2; }
    | IDENT                    { 
                                if(!$1->defined){
                                    fprintf(stderr, "%s not defined (line %d)\n", yytext, yylineno);
                                    exit(1);
                                }
                                $$ = $1->value; }
    ;

arithmeticOp:
    expression PLUS expression      { $$ = $1 + $3; }
    | expression MINUS expression   { $$ = $1 - $3; }
    | expression TIMES expression   { $$ = $1 * $3; }
    | expression DIVIDE expression  { $$ = $1 / $3; }
    ;

%%
    /* Código */

void yyerror(const char *s) {
    fprintf(stderr, "%s near '%s' (line %d)\n", s, yytext, yylineno);
}