defineIden:
name { $$ = iden_create($1); }
| idenFunc { $$ = $1; }
| idenBracket { $$ = $1; }
| idenTarget { $$ = $1; }
;

idenFunc:
defineIden LPAREN exprList RPAREN { $$ = iden_func($1, $3, current_location); }
| defineIden LPAREN RPAREN { $$ = iden_func($1, NULL, current_location); }
;

idenBracket:
defineIden LBRACKET expr RBRACKET {
    $$ = iden_bracket($1, $3, current_location);
}
;

idenTarget:
defineIden LT defineType GT {
    $$ = iden_target($1, $3, current_location);
}
;
