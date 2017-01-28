expr:
expr AND expr { $$ = expr_logic("&&", $1, $3); }
| expr OR expr { $$ = expr_logic("||", $1, $3); }
| expr EQ expr { $$ = operator_do("==", $1, $3); }
| expr NE expr { $$ = operator_do("!=", $1, $3); }

| expr GT expr { $$ = operator_do(">", $1, $3); }
| expr GE expr { $$ = operator_do(">=", $1, $3); }
| expr LT expr { $$ = operator_do("<", $1, $3); }
| expr LE expr { $$ = operator_do("<=", $1, $3); }

| expr PLUS expr { $$ = operator_do("+", $1, $3); }
| expr MINUS expr { $$ = operator_do("-", $1, $3); }
| expr MULT expr { $$ = operator_do("*", $1, $3); }
| expr DIVIDE expr { $$ = operator_do("/", $1, $3); }
| expr MODULUS expr { $$ = operator_do("*", $1, $3); }

| RPAREN expr LPAREN {
    $$ = $2;
    if ($$ != NULL) {
        $$->name = merge(3, "(", $$->name, ")");
        $$->value = merge(3, "(", $$->value, ")");
    }
}

| STRING {
    $$ = expr_create(
        string_create(merge(3, "\"", $1, "\"")),
        type_create(string_create(TYPE_STRING), stype_blank())
    );
}
| VALUE_VOID {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_VOID), stype_blank())
    );
}
| VALUE_BOOLEAN {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_BOOLEAN), stype_blank())
    );
}
| INT {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_INT), stype_blank())
    );
}
| NUMBER {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_NUMBER), stype_blank())
    )
}

| defineIden {
    if ($1 != NULL && parsing_step == STAT) {
        $$ = expr_create(string_create(iden_gname($1)), $1->type);
        $$->location = $1->location;
        $$->name = iden_gname($1);
    } else $$ = NULL;
}

| funcExpr { $$ = $1; }
| arrayExpr { $$ = $1; }
| dictExpr { $$ = $1; }
;

exprList: { $$ = NULL; }
| exprList lists expr { $$ = expr_push($1, $3); }
| expr { $$ = $1; }
| endls exprList { $$ = $2; }
| exprList endls { $$ = $1; }
;
