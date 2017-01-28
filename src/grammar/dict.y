dictType:
LBRACE defineType RBRACE {
    $$ = dict_type($2);
}
;

dictExpr:
LBRACE dictContext RBRACE {
    if (parsing_step == STAT) {
        if ($2 == NULL) {
            $$ = expr_create(
                string_create("undefined"),
                type_create(string_create(TYPE_VOID), stype_blank())
            );
        } else {
            type* ctype = $2->type;
            expr* dlist = $2->next;
            for (; dlist != NULL; dlist = dlist->next) {
                if (!type_compare(ctype, dlist->type)) {
                    if (type_compare(dlist->type, ctype)) {
                        ctype = dlist->type;
                    } else {
                        // Turn array into any type
                        $$ = NULL;
                        return 1;
                    }
                }
            }
            $$ = expr_create(string_create(merge(3, "{", expr_name($2), "}")),
                type_create(string_create(TYPE_DICT), stype_dict(dict_create(ctype)))
            );
            if ($$ != NULL) {
                $$->value = merge(3, "{", expr_string($2), "}");
                $$->location = location_plus($1, $3);
                $$->type->code = merge(3, "{", ctype->code, "}");
            }
        }
    } else $$ = NULL;
}
;

dictContext: { $$ = NULL; }
| dictContext lists dictList { $$ = expr_push($1, $3); }
| dictList { $$ = $1; }
| endls dictContext { $$ = $2; }
| dictContext endls { $$ = $1; }
;

dictList:
name expr {
    if ($1 != NULL && $2 != NULL) {
        $$ = expr_create($1, $2->type);
        if ($$ != NULL) {
            $$->name = merge(4, "\"", $1->name, "\" ", $2->name);
            $$->value = merge(4, "\"", $1->name, "\":", $2->value);
        }
    } else $$ = NULL
}
;
