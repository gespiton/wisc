%{
    #include "grammar.h"
    #include "core.h"

    #define YY_USER_ACTION  yylval.sval = strdup(yytext); \
                            current_location = location_create(col_number, line_number, col_number + yyleng - 1, line_number); \
                            col_number += yyleng;
%}

%%

";"                         { return SEMICOLON; }
","                         { return COLON; }

[a-zA-Z][a-zA-Z_0-9]*       { return NAME; }
\n                          { col_number = 1; line_number++; return ENDL; }
.                           { ; }

%%

int yywrap() { return 1; }
