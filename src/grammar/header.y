%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #include "core.h"

    extern int yylex();
%}

%union {
    char* sval;

    struct location* location;

    struct func* func;

    struct string* string;
    struct type* type;
    struct iden* iden;
    struct param* param;
    struct expr* expr;
}

%token NAME ENDL INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%token SEMICOLON COLON ASSIGN RPAREN LPAREN RBRACE LBRACE COMMA
%token RETURN

%type <sval> NAME INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%type <sval> stats stat

%type <location> RETURN

%type <func> funcHeaderV

%type <string> name
%type <type> defineType typeListP typeList funcType
%type <iden> defineIden idenFunc
%type <param> defineParam paramListP paramList
%type <expr> expr exprList

%start program

%%

endls:
endls ENDL { ; }
| ENDL { ; }
;

endc:
SEMICOLON { ; }
| endls { ; }
;

list:
COMMA { ; }
| list endls { ; }
;

name: NAME { $$ = string_create($1); }

program: { ; }
| space { ; }
;
