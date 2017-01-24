subSpace:
RBRACE space LBRACE { ; }
| endls subSpace { ; }
;

space:
defineStats stats { ; }
;

controlSpace:
RETURN expr { stat_return($1, $2); }
| RETURN { stat_return($1, expr_create(string_create(""), type_create(string_create(TYPE_VOID), stype_blank()))); }
| BREAK { stat_loop(0); }
| CONTINUE { stat_loop(1); }
;
