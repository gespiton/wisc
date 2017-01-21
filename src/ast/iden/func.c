if (target == NULL) return NULL;
// Check if target type is a function
if (target->type->stype->func == NULL) {
    error(ISNT_FUNCTION, concat(token(iden_name(target)), " is not a function"), target->location);
    return NULL;
}

char* name = "";
char* gname = "";
type* call_type = NULL;
if (target->attach != NULL) {
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
            concat("Calling function failed, passing params does not match with any function ", token(cvar->name)),
            location_plus(target->location, location));
        var* chvar = target->attach;
        for (; chvar != NULL; chvar = chvar->next)
            note(merge(3, "Function ", token(chvar->name), " was define here"), chvar->location);
        return NULL;
    } else {
        name = merge(4, iden_name(target), "(", expr_name(params), ")");
        gname = merge(4, iden_gname(target), "(", expr_string(params), ")");
        call_type = cvar->type->stype->func->return_type;
    }
} else {
    if (!type_compare_list(param_to_type(target->type->stype->func->params_list), expr_to_type(params))) {
        name = merge(4, iden_name(target), "(", expr_name(params), ")");
        gname = merge(4, iden_gname(target), "(", expr_string(params), ")");
        call_type = target->type->stype->func->return_type;
    } else {
        error(CALLING_FUNC_FAILED,
            "Calling function failed, passing params does not match",
            location_plus(target->location, location));
        return NULL;
    }
}
# new niden name name type call_type location location_plus(target->location,location) gname gname attach NULL
return niden;
