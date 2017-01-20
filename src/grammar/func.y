defineFunc:
defineType name funcHeaderV {
    if (parsing_step == DEFINE) {
        // Check if name already exist
        var* svar = space_search_define(current_space, $2->name, 0);
        if (svar == NULL) {
            space_add_var(
                var_create(
                    param_create(
                        string_create($2->name),
                        func_type($3),
                        NULL) ));
            space_create();
        } else {
            space_add_var(svar);
        }
    } else if (parsing_step == STAT) {
        space_next();
        output("", merge(4, "Define function ", $2->name, " type ", $1->code), location_plus($1->location, $3->location));
    }
} subSpace {
    if (parsing_step < TYPE) {
        space_end();
    }
}
;

funcHeaderV:
RPAREN paramList LPAREN {
    string* typeString = string_create(TYPE_VOID);
    typeString->location = NULL;
    $$ = func_create(type_create(typeString, NULL), $2);
    if ($$ != NULL)
        $$->location = current_location;
}
;
