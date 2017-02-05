if (left == NULL || right == NULL || symbol == NULL) return NULL;

if (strcmp(left->type->code, TYPE_ANY) == 0 ||
    strcmp(right->type->code, TYPE_ANY) == 0) {
    return expr_create(
        string_create(merge(3, left->value, symbol, right->value)),
        type_create(string_create(TYPE_ANY), NULL)
    );
} else {
    operator* copt = operator_search(operator_create(symbol, left->type, right->type, ""));
    if (copt == NULL) {
        error(CANNOT_OPERATOR_WITH,
            merge(6, "Type ", token(left->type->code), " cannot operator ", token(symbol), " with type ", token(right->type->code)),
            location_plus(left->location, right->location)
        );
        return NULL;
    }
    expr* nexpr = expr_create(
        string_create(merge(3, left->value, symbol, right->value)),
        type_create(string_create(copt->output), stype_blank())
    );
    if (nexpr != NULL) {
        nexpr->value = merge(5, left->value, " " , symbol, " ", right->value);
        nexpr->location = location_plus(left->location, right->location);
    }

    return nexpr;
}
