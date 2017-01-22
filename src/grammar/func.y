defineFunc:
defineType name funcHeaderV {
    if (parsing_step == DEFINE) {
        int lock = 0;
        if ($1 != NULL && $3 != NULL) {
            $3->return_type = $1;
            if (strcmp($3->return_type->code, TYPE_VOID) == 0) $3->have_return = 1;
            else $3->have_return = 0;
            var* nvar = var_create(param_create($2, func_type($3), NULL));
            nvar->location = location_plus($1->location, $3->location);
            if (!space_add_var(nvar)) lock = 1;
        } else lock = 1;
        space_create();
        current_space->lock = lock;
        current_space->func = $3;
        $3->location = location_plus($1->location, $3->location);
        if (!lock) {
            // Add variable params
            param* cp = $3->params_list;
            for (; cp != NULL; cp = cp->next) {
                var* nvar = var_create(cp);
                space_add_var(nvar);
            }
        }
    } else if (parsing_step == STAT) {
        space_next();
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT && current_space->func != NULL && !current_space->func->have_return)
            warning(merge(3, "Function ", token($2->name), " is non-void"), location_plus($1->location, $3->location));
        space_end();
    }
}
;

funcExpr:
funcHeaderE {
    if (parsing_step == DEFINE) {
        space_create();
        if ($1 != NULL) {
            current_space->func = $1;
            // Add define params
            param* cp = $1->params_list;
            for (; cp != NULL; cp = cp->next) {
                var* nvar = var_create(cp);
                space_add_var(nvar);
            }
        } else current_space->lock = 1;
    } else if (parsing_step == STAT) {
        space_next();
        if (!current_space->lock) {
            $<expr>$ = expr_create(string_create("function"), func_type($1));
            $<expr>$->location = $1->location;
        } else $<expr>$ = NULL;
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT) {
            $$ = $<expr>2;
            if (current_space->func != NULL && !current_space->func->have_return)
                warning("Function is non-void", current_space->func->location);
        } else $$ = NULL;
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

funcHeaderE:
RPAREN { $<location>$ = current_location; } paramList LPAREN COLON defineType {
    $$ = func_create($6, $3);
    if ($$ != NULL && $6 != NULL) {
        $$->location = location_plus($<location>2, $6->location);
    }
}
;

funcType:
defineType COLON RPAREN typeList LPAREN {
    $$ = func_type(func_create($1, type_to_param($4)));
    if ($$ != NULL)
        $$->location = location_plus($1->location, current_location);
}
;
