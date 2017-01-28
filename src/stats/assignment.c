if (iden == NULL || expr == NULL) return "";

if (iden->attach == NULL) {
    error(INVALID_LEFT_HAND, "Invalid left-hand side in assignment", iden->location);
    return "";
}

if (iden->attach->read_only) {
    error(ASSIGNMENT_CONSTANT_VAR, concat(token(iden_name(iden)), " is constant variable cannot be assigned"), iden->location);
    return "";
}

if (!type_compare(iden->type, expr->type)) {
    error(VAR_CANNOT_MATCH,
        merge(6, "Variable ", token(iden_name(iden)), " type ", token(iden->type->code), " cannot match with ", token(expr->type->code)),
        location_plus(iden->location, expr->location));
    note(merge(3, "Variable ", token(iden_name(iden)), " was define here"), iden->attach->location);

    return "";
}

debug(merge(4, "Assign ", token(iden_name(iden)), " = ", token(expr->name)), location_plus(iden->location, expr->location));
current_space->generate = merge(4, current_space->generate, iden_gname(iden), "=", expr->value, ";");

return "";
