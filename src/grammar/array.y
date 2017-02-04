arrayType:
defineType BRACKET {
    $$ = array_type($1);
}
;

arrayExpr:
LBRACKET exprList RBRACKET {
    if (parsing_step == STAT) {
        if ($2 == NULL) {
            $$ = expr_create(
                string_create("undefined"),
                type_create(string_create(TYPE_VOID), stype_blank())
            );
        } else {
            type* ctype = $2->type;
            expr* cexpr = $2->next;
            for (; cexpr != NULL; cexpr = cexpr->next) {
                if (!type_compare(ctype, ctype, cexpr->type)) {
                    if (type_compare(cexpr->type, cexpr->type, ctype)) {
                        ctype = cexpr->type;
                    } else {
                        ctype = type_multiple(ctype, cexpr->type);
                    }
                }
            }
            $$ = expr_create(
                string_create(merge(3, "[", expr_string($2), "]")),
                type_create(string_create(TYPE_ARRAY), stype_array(array_create(ctype)))
            );
            if ($$ != NULL) {
                $$->location = location_plus($1, $3);
                if (ctype->multiple == NULL) $$->type->code = concat(ctype->code, "[]");
                else $$->type->code = merge(4, "(", ctype->code, ")", "[]");
                $$->type->name = $$->type->code;
            }
        }
    } else $$ = NULL;
}
;
