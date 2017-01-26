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

%left PLUS MINUS
%left MULT DIVIDE MODULUS

%token NAME ENDL INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%token SEMICOLON COLON ASSIGN RPAREN LPAREN RBRACE LBRACE COMMA
%token DINIT DEND
%token RETURN IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK CONTINUE OPERATOR
%token PLUS EPLUS DPLUS MINUS EMINUS DMINUS MULT EMULT DIVIDE EDIVIDE MODULUS EMODULUS OR AND OPPOSITE

%type <sval> NAME INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%type <sval> stats stat operator

%type <location> RETURN IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK CONTINUE

%type <func> funcHeaderV funcHeaderE

%type <string> name
%type <type> defineType typeListP typeList funcType
%type <iden> defineIden idenFunc
%type <param> defineParam paramListP paramList
%type <expr> expr exprList funcExpr

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
| init { ; }
| space { ; }
;
