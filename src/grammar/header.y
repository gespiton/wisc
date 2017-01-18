%{
    #include <stdio.h>
    #include <stdlib.h>

    #include "core.h"

    extern int yylex();
%}

%union {
    char* sval;

    struct string* string;
    struct type* type;
    struct param* param;
}

%locations

%token NAME ENDL
%token SEMICOLON COLON

%type <sval> NAME
%type <sval> stats stat

%type <string> name
%type <type> defineType
%type <param> defineParam paramListP

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
COLON { ; }
| list endls { ; }
;

name: NAME { $$ = string_create($1); }

program: { if (parsing_step == STAT) current_file->generate = ""; }
| stats { if (parsing_step == STAT) current_file->generate = $1; }
;
