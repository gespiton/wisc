expr:
STRING {
    $$ = expr_create(
        string_create(merge(3, "\"", $1, "\"")),
        type_create(string_create(TYPE_STRING))
    );
}
| VALUE_VOID {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_VOID))
    );
}
| VALUE_BOOLEAN {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_BOOLEAN))
    );
}
| INT {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_INT))
    );
}
| NUMBER {
    $$ = expr_create(
        string_create($1),
        type_create(string_create(TYPE_NUMBER))
    )
}

| defineIden {
    if ($1 != NULL && parsing_step == STAT) {
        $$ = expr_create(string_create(iden_name($1)), $1->type);
        $$->location = $1->location;
    } else $$ = NULL;
}
;
