if (current_space->func == NULL) {
    if (expr != NULL)
        error(RETURN_NOT_ALLOW_HERE, "Return not allow here", location_plus(location, expr->location));
    else error(RETURN_NOT_ALLOW_HERE, "Return not allow here", location);
    return "";
}

int herror = 0;
if (strcmp(current_space->func->return_type->code, TYPE_VOID) == 0 && expr != NULL) {
    error(RETURN_NOT_MATCH,
        merge(4,
            "Current function was define by type ",
            token("void"),
            " cannot return value type ",
            token(expr->type->code)), location_plus(location, expr->location));
    herror = 1;
} else if (strcmp(current_space->func->return_type->code, TYPE_VOID) != 0 && expr == NULL) {
    error(RETURN_NOT_MATCH,
        merge(4,
            "Current function was define by type ",
            token(current_space->func->return_type->code),
            " cannot return value type ",
            token("void")), location);
    herror = 1;
} else if (!type_compare(current_space->func->return_type, expr->type)) {
    error(RETURN_NOT_MATCH,
        merge(4,
            "Current function was define by type ",
            token(current_space->func->return_type->code),
            " cannot return value type ",
            token(expr->type->code)), location_plus(location, expr->location));
    herror = 1;
}

if (herror) {
    note("Function was define here", current_space->func->location);
    return "";
} else {
    current_space->func->have_return = 1;
    current_space->generate = merge(4, current_space->generate, "return ", expr->value, ";");
}

return "";
