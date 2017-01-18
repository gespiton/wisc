%{
    #include "grammar.h"
    #include "core.h"
%}

%%

";"                         { return SEMICOLON; }

[a-zA-Z][a-zA-Z_0-9]*       { return NAME; }
\n                          { col_number = 1; line_number++; }
.                           { ; }

%%

int yywrap() { return 1; }
