if (target == NULL) return NULL;
// Check if target type is a function
if (strcmp(target->type->code, TYPE_ANY) == 0) {
} else if (target->type->stype->func == NULL) {
    error(ISNT_FUNCTION, concat(token(iden_name(target)), " is not a function"), target->location);
    return NULL;
}

# new niden location location_plus(target->location,location)
if (strcmp(target->type->code, TYPE_ANY) == 0) {
    niden->name = merge(4, iden_name(target), "(", expr_name(params), ")");
    niden->gname = merge(4, iden_gname(target), "(", expr_string(params), ")");
    niden->type = target->type;
} else if (target->attach != NULL) {
    var* cvar = target->attach;
    int fail = 0;
    for (; cvar != NULL; cvar = cvar->next) {
        if (!type_compare_list(param_to_type(cvar->type->stype->func->params_list), expr_to_type(params))) {
            break;
        }
        else if (cvar->next == NULL) {
            fail = 1;
            break;
        }
    }

    if (fail) {
        error(CALLING_FUNC_FAILED,
            merge(4, "Calling function failed, passing params ", token(merge(3, "(", type_string(expr_to_type(params)), ")")), " does not match with any function ", token(cvar->name)),
            location_plus(target->location, location));
        var* chvar = target->attach;
        for (; chvar != NULL; chvar = chvar->next) {
            if (chvar->type->stype->func->params_list != NULL)
                note(merge(5, "Function ", token(chvar->name), " was define with params ", token(merge(3, "(", type_string(param_to_type(chvar->type->stype->func->params_list)), ")")), " here"), chvar->location);
            else note(merge(5, "Function ", token(chvar->name), " was define with params ", token("()"), " here"), chvar->location);
        }
        return NULL;
    } else {
        niden->name = merge(4, cvar->name, "(", expr_name(params), ")");
        niden->gname = merge(4, cvar->gname, "(", expr_string(params), ")");
        niden->type = cvar->type->stype->func->return_type;
    }
} else {
    if (!type_compare_list(param_to_type(target->type->stype->func->params_list), expr_to_type(params))) {
        niden->name = merge(4, iden_name(target), "(", expr_name(params), ")");
        niden->gname = merge(4, iden_gname(target), "(", expr_string(params), ")");
        niden->type = target->type->stype->func->return_type;
    } else {
        error(CALLING_FUNC_FAILED,
            merge(3, "Calling function failed, passing params ", token(merge(3, "(", type_string(expr_to_type(params)), ")")), " does not match"),
            location_plus(target->location, location));
        return NULL;
    }
}
return niden;
