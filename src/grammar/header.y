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

%left AND OR
%left EQ NE
%left GT GE
%left LT LE
%left PLUS MINUS
%left MULT DIVIDE MODULUS

%token NAME ENDL INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%token SEMICOLON COLON ASSIGN RPAREN LPAREN RBRACE LBRACE COMMA BRACKET RBRACKET LBRACKET
%token DINIT DEND
%token RETURN IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK CONTINUE OPERATOR CONST
%token EQ NE GT GE LT LE
%token PLUS EPLUS DPLUS MINUS EMINUS DMINUS MULT EMULT DIVIDE EDIVIDE MODULUS EMODULUS OR AND OPPOSITE

%type <sval> NAME INT NUMBER STRING VALUE_BOOLEAN VALUE_VOID
%type <sval> stats stat operator

%type <location> RETURN IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK CONTINUE
%type <location> SEMICOLON COLON ASSIGN RPAREN LPAREN RBRACE LBRACE COMMA BRACKET RBRACKET LBRACKET
%type <location> EQ NE GT GE LT LE
%type <location> PLUS EPLUS DPLUS MINUS EMINUS DMINUS MULT EMULT DIVIDE EDIVIDE MODULUS EMODULUS OR AND OPPOSITE

%type <func> funcHeaderV funcHeaderE

%type <string> name
%type <type> defineType typeListP typeList funcType arrayType dictType
%type <iden> defineIden idenFunc idenBracket
%type <param> defineParam paramListP paramList
%type <expr> expr exprList funcExpr arrayExpr dictExpr dictContext dictList

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

lists:
| list { ; }
| endls { ; }
;

name: NAME { $$ = string_create($1); }

program: { ; }
| init { ; }
| space { ; }
;
