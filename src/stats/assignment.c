if (iden == NULL || expr == NULL) return "";

if (iden->attach == NULL) {
    error(INVALID_LEFT_HAND, "Invalid left-hand side in assignment", iden->location);
    return "";
}

if (iden->attach->read_only) {
    error(ASSIGNMENT_CONSTANT_VAR, concat(token(iden_name(iden)), " is constant variable cannot be assigned"), iden->location);
    return "";
}

if (!type_compare(iden->type, NULL, expr->type)) {
    error(VAR_CANNOT_MATCH,
        merge(6, "Variable ", token(iden_name(iden)), " type ", token(iden->type->name), " cannot match with ", token(expr->type->name)),
        location_plus(iden->location, expr->location));
    note(merge(3, "Variable ", token(iden_name(iden)), " was define here"), iden->attach->location);

    return "";
}

debug(merge(4, "Assign ", token(iden_name(iden)), " = ", token(expr->name)), location_plus(iden->location, expr->location));
char* result = merge(4, iden_gname(iden), " = ", expr->value, ";");
space_context(current_space, result, 1);
return result;
