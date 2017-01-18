%{
    #include <stdio.h>
    #include <stdlib.h>

    #include "core.h"

    extern int yylex();
%}

%union {
    char* string;
}

%token NAME ENDL
%token SEMICOLON

%type <string> NAME
%type <string> stats stat

%start program

%%

endls:
endls ENDL { ; }
| ENDL { ; }
;

endc:
endls { ; }
| SEMICOLON { ; }
;

program: { if (parsing_step == STAT) current_file->generate = ""; }
| stats { if (parsing_step == STAT) current_file->generate = $1; }
;
