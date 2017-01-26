if (left == NULL || right == NULL || symbol == NULL) return NULL;


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

return nexpr;
