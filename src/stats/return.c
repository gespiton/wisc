if (expr == NULL) return "";

if (current_space->func == NULL) {
    if (expr != NULL)
        error(RETURN_NOT_ALLOW_HERE, "Return not allow here", location_plus(location, expr->location));
    else error(RETURN_NOT_ALLOW_HERE, "Return not allow here", location);
    return "";
}

if (!type_compare(current_space->func->return_type, NULL, expr->type)) {
    error(RETURN_NOT_MATCH,
        merge(4,
            "Current function was define by type ",
            token(current_space->func->return_type->name),
            " cannot return value type ",
            token(expr->type->name)), location_plus(location, expr->location));
    note("Function was define here", current_space->func->location);
    return "";
}

current_space->func->have_return = 1;
space_context(current_space, merge(3, "return ", expr->value, ";"), 1);

return "";
