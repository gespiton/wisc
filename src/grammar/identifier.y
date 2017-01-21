defineIden:
name { $$ = iden_create($1); }
| idenFunc { $$ = $1; }
;

idenFunc:
defineIden RPAREN exprList LPAREN { $$ = iden_func($1, $3, current_location); }
;
