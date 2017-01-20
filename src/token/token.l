%{
    #include "grammar.h"
    #include "core.h"

    #define YY_USER_ACTION  yylval.sval = strdup(yytext); \
                            current_location = location_create(col_number, line_number, col_number + yyleng - 1, line_number); \
                            col_number += yyleng;

    char* on_string;
%}

%x STRINGQ
%x STRINGA

%%

";"                         { return SEMICOLON; }
":"                         { return COLON; }
","                         { return COMMA; }
"="                         { return ASSIGN; }
"("                         { return RPAREN; }
")"                         { return LPAREN; }
"{"                         { return RBRACE; }
"}"                         { return LBRACE; }

"true"                      { return VALUE_BOOLEAN; }
"false"                     { return VALUE_BOOLEAN; }
"undefined"                 { return VALUE_VOID; }
"null"                      { return VALUE_VOID; }

[a-zA-Z][a-zA-Z_0-9]*       { return NAME; }
[0-9]+                      { return INT; }
\+[0-9]+                    { yylval.sval = &yylval.sval[1]; return INT; }
\-[0-9]+                    { return INT; }
[0-9]+\.[0-9]+               { return NUMBER; }
\.[0-9]+                    { yylval.sval = concat("0", yytext); return NUMBER; }
\-[0-9]+\.[0-9]+             { return NUMBER; }
\-\.[0-9]+                  { yylval.sval = concat("-0", &yylval.sval[1]); return NUMBER; }

\"                          { BEGIN(STRINGQ); on_string = ""; }
<STRINGQ>\"                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); return STRING; }
<STRINGQ>\n                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); return STRING; }
<STRINGQ>\\.                { on_string = concat(on_string, yytext); }
<STRINGQ>.                  { on_string = concat(on_string, yytext); }

\'                          { BEGIN(STRINGA); on_string = ""; }
<STRINGA>\'                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); return STRING; }
<STRINGA>\n                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); return STRING; }
<STRINGA>\"                 { on_string = concat(on_string, "\\\""); }
<STRINGA>\\.                { on_string = concat(on_string, yytext); }
<STRINGA>.                  { on_string = concat(on_string, yytext); }

\n                          { col_number = 1; line_number++; return ENDL; }
.                           { ; }


%%

int yywrap() { return 1; }
