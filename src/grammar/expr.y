expr:
STRING {
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
;

exprList: { $$ = NULL; }
| exprList list expr { $$ = expr_push($1, $3); }
| expr { $$ = $1; }
;
