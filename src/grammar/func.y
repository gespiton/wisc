defineFunc:
defineType name funcHeaderV {
    if (parsing_step == DEFINE) {
        int lock = 0;
        char* gname = "";
        if ($1 != NULL && $3 != NULL) {
            $3->return_type = $1;
            if (strcmp($3->return_type->code, TYPE_VOID) == 0) $3->have_return = 1;
            else $3->have_return = 0;
            var* nvar = var_create(param_create($2, func_type($3), NULL));
            nvar->location = location_plus($1->location, $3->location);
            nvar->define_func = 1;
            if (!space_add_var(nvar, 0)) lock = 1;
            gname = nvar->gname;
        } else lock = 1;
        space_create();
        current_space->lock = lock;
        current_space->func = $3;
        if (!lock) {
            $3->location = location_plus($1->location, $3->location);
            // Add variable params
            param* cp = $3->params_list;
            for (; cp != NULL; cp = cp->next) {
                var* nvar = var_create(cp);
                space_add_var(nvar, 1);
            }
            space_header(current_space, merge(3, "function ", gname, " ("));
        }
    } else if (parsing_step == STAT) {
        space_next();
        if (!current_space->lock) {
            char* paramString = "";
            param* cp = $3->params_list;
            for (; cp != NULL; cp = cp->next) {
                var* cvar = space_search_var(current_space, cp->name, 0);
                if (cvar != NULL) paramString = concat(paramString, cvar->gname);
                if (cp->next != NULL) paramString = concat(paramString, ", ");

                if (cvar != NULL && cp->expr != NULL)
                    space_init(current_space, merge(7, "if (", cvar->name, " == undefined) ", cvar->gname, " = ", cp->expr->value, ";"));
            }
            space_header(current_space, merge(3, current_space->header, paramString, ")"));
        }
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT && current_space->func != NULL && !current_space->func->have_return)
            warning(merge(3, "Function ", token($2->name), " is non-void"), location_plus($1->location, $3->location));
        if (parsing_step == STAT && current_space->func != NULL)
            space_context(current_space->parent, space_generate(current_space), 1);
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
            char* paramString = "";
            for (; cp != NULL; cp = cp->next) {
                var* nvar = var_create(cp);
                space_add_var(nvar, 1);
                paramString = concat(paramString, nvar->gname);
                if (cp->next != NULL) paramString = concat(paramString, ", ");
            }
            space_header(current_space, merge(3, "function (", paramString, ")"));
        } else current_space->lock = 1;
    } else if (parsing_step == STAT) {
        space_next();
        if (!current_space->lock) {
            $<expr>$ = expr_create(string_create(""), func_type($1));
            $<expr>$->location = $1->location;

            param* cp = $1->params_list;
            for (; cp != NULL; cp = cp->next) {
                var* cvar = space_search_var(current_space, cp->name, 0);
                if (cvar != NULL && cp->expr != NULL)
                    space_init(current_space, merge(7, "if (", cvar->name, " == undefined) ", cvar->gname, " = ", cp->expr->value, ";"));
            }
        } else $<expr>$ = NULL;
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT) {
            $$ = $<expr>2;
            $$->name = $$->value = space_generate(current_space);
            if (current_space->func != NULL && !current_space->func->have_return)
                warning("Function is non-void", current_space->func->location);
        } else $$ = NULL;
        space_end();
    }
}
;

funcHeaderV:
LPAREN paramList RPAREN {
    string* typeString = string_create(TYPE_ANY);
    typeString->location = NULL;
    $$ = func_create(type_create(typeString, NULL), $2);
    if ($$ != NULL)
        $$->location = current_location;
}
;

funcHeaderE:
LPAREN { $<location>$ = current_location; } paramList RPAREN COLON defineType {
    $$ = func_create($6, $3);
    if ($$ != NULL && $6 != NULL) {
        $$->location = location_plus($<location>2, $6->location);
    }
}
;

funcType:
defineType COLON LPAREN typeList RPAREN {
    $$ = func_type(func_create($1, type_to_param($4)));
    if ($$ != NULL) {
        $$->location = location_plus($1->location, current_location);
    }
}
;
