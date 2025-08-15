
DIGITO  [0-9]
INTEIRO {DIGITO}+
DEZENA  {DIGITO}{2}
ANO     {DIGITO}{4}
DATA    {ANO}-{DEZENA}-{DEZENA}     
HORAMIN {DEZENA}:{DEZENA}
PERM    [rwx-]{3}
TIPO    [-dcbl]
PERMS   ^{TIPO}{PERM}{3}

%%

{PERMS}          { printf("%s\n", yytext); }
{HORAMIN}|{DATA} { printf("%s\n", yytext); }

\n      ;
.       ;

%%

