operator:
PLUS { $$ = "+"; }
| MINUS { $$ = "-"; }
| MULT { $$ = "*"; }
| DIVIDE { $$ = "/"; }
| MODULUS { $$ = "%"; }
| EQ { $$ = "=="; }
| NE { $$ = "!="; }
| GT { $$ = ">"; }
| GE { $$ = ">="; }
| LT { $$ = "<"; }
| LE { $$ = "<="; }
;
