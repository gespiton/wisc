%{
    #include "grammar.h"
    #include "core.h"

    #define YY_USER_ACTION  yylval.sval = strdup(yytext); \
                            current_location = location_create(col_number, line_number, col_number + yyleng - 1, line_number); \
                            col_number += yyleng;

    char* on_string;
    location* string_location;
%}

%x COMMENTS
%x STRINGQ
%x STRINGA

%%

";"                         { yylval.location = current_location; return SEMICOLON; }
":"                         { yylval.location = current_location; return COLON; }
","                         { yylval.location = current_location; return COMMA; }
"="                         { yylval.location = current_location; return ASSIGN; }
"("                         { yylval.location = current_location; return LPAREN; }
")"                         { yylval.location = current_location; return RPAREN; }
"{"                         { yylval.location = current_location; return LBRACE; }
"}"                         { yylval.location = current_location; return RBRACE; }
"[]"                        { yylval.location = current_location; return BRACKET; }
"["                         { yylval.location = current_location; return LBRACKET; }
"]"                         { yylval.location = current_location; return RBRACKET; }

"|"                         { yylval.location = current_location; return SOR; }

">>"                        { yylval.location = current_location; return RARROW; }

"=="                        { yylval.location = current_location; return EQ; }
"!="                        { yylval.location = current_location; return NE; }
"<"                         { yylval.location = current_location; return LT; }
"<="                        { yylval.location = current_location; return LE; }
">"                         { yylval.location = current_location; return GT; }
">="                        { yylval.location = current_location; return GE; }
"||"                        { yylval.location = current_location; return OR; }
"&&"                        { yylval.location = current_location; return AND; }
"+"                         { yylval.location = current_location; return PLUS; }
"-"                         { yylval.location = current_location; return MINUS; }
"*"                         { yylval.location = current_location; return MULT; }
"/"                         { yylval.location = current_location; return DIVIDE; }
"%"                         { yylval.location = current_location; return MODULUS; }

"#init"                     { return DINIT; }
"#end"                      { return DEND; }

"return"                    { yylval.location = current_location; return RETURN; }
"if"                        { yylval.location = current_location; return IF; }
"else"                      { yylval.location = current_location; return ELSE; }
"for"                       { yylval.location = current_location; return FOR; }
"while"                     { yylval.location = current_location; return WHILE; }
"switch"                    { yylval.location = current_location; return SWITCH; }
"case"                      { yylval.location = current_location; return CASE; }
"default"                   { yylval.location = current_location; return DEFAULT; }
"break"                     { yylval.location = current_location; return BREAK; }
"continue"                  { yylval.location = current_location; return CONTINUE; }
"operator"                  { yylval.location = current_location; return OPERATOR; }
"const"                     { yylval.location = current_location; return CONST; }
"typedef"                   { yylval.location = current_location; return TYPEDEF; }

"true"                      { return VALUE_BOOLEAN; }
"false"                     { return VALUE_BOOLEAN; }
"undefined"                 { return VALUE_VOID; }
"null"                      { return VALUE_VOID; }

[a-zA-Z_][a-zA-Z_0-9]*      { return NAME; }
[0-9]+                      { return INT; }
\+[0-9]+                    { yylval.sval = &yylval.sval[1]; return INT; }
\-[0-9]+                    { return INT; }
[0-9]+\.[0-9]+              { return NUMBER; }
\.[0-9]+                    { yylval.sval = concat("0", yytext); return NUMBER; }
\-[0-9]+\.[0-9]+            { return NUMBER; }
\-\.[0-9]+                  { yylval.sval = concat("-0", &yylval.sval[1]); return NUMBER; }

\/\*                        { BEGIN(COMMENTS); }
<COMMENTS>\*\/              { BEGIN(INITIAL); }
<COMMENTS>\n                { ++line_number; }
<COMMENTS>.                 { ; }

\"                          { BEGIN(STRINGQ); on_string = ""; string_location = current_location; }
<STRINGQ>\"                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); current_location = location_plus(string_location, current_location); return STRING; }
<STRINGQ>\n                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); current_location = location_plus(string_location, current_location); return STRING; }
<STRINGQ>\\.                { on_string = concat(on_string, yytext); }
<STRINGQ>.                  { on_string = concat(on_string, yytext); }

\'                          { BEGIN(STRINGA); on_string = ""; string_location = current_location; }
<STRINGA>\'                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); current_location = location_plus(string_location, current_location); return STRING; }
<STRINGA>\n                 { BEGIN(INITIAL); yylval.sval = strdup(on_string); current_location = location_plus(string_location, current_location); return STRING; }
<STRINGA>\"                 { on_string = concat(on_string, "\\\""); }
<STRINGA>\\.                { on_string = concat(on_string, yytext); }
<STRINGA>.                  { on_string = concat(on_string, yytext); }

\n                          { col_number = 1; line_number += 1; return ENDL; }
"//".*\n                    { line_number += 1; }
.                           { ; }


%%

int yywrap() { return 1; }
