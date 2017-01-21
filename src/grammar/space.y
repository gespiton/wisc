subSpace:
RBRACE space LBRACE { ; }
;

space:
defineStats stats { ; }
;

controlSpace:
RETURN expr { stat_return($1, $2); }
| RETURN { stat_return($1, NULL); }
;
