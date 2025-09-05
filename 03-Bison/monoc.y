%{  /* Declarações */
    #include <stdio.h> // printf, ...

    int yylex();                    // Declara função do analizador léxico
    void yyerror(const char* s);    // Declara função para tratamento de erros
    extern int yylineno;            // Variável com o número da linha atual
    extern char *yytext;            // Variável com o texto atual sendo analizado
%}

 // Tokens, tipos, precedências, etc.

%token PRINT 
%token LPAREN
%token RPAREN
%token SEMICOLON
%token INTLITERAL
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
%token IDENT

%left PLUS MINUS
%left TIMES DIVIDE

%%

    /* Regras sintáticas e ações semanticas */
program:
    program command
    | /* programa vazio */
    ; 

command:
    PRINT LPAREN RPAREN SEMICOLON               { printf("\n"); }
    | PRINT LPAREN expression RPAREN SEMICOLON  { printf("%d\n", $3); }
    ;

expression:
    INTLITERAL          { $$ = $1; }
    | arithmeticOp      { }
    ;

arithmeticOp:
    expression PLUS expression      { $$ = $1 + $3; }
    | expression MINUS expression   { $$ = $1 - $3; }
    ;

%%
    /* Código */

void yyerror(const char *s) {
    fprintf(stderr, "%s near '%s' (line %d)\n", s, yytext, yylineno);
}
