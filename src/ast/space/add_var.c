if (parsing_step != DEFINE) return 0;
if (variable == NULL) return 0;

// Search if variable name already exists
var* cvar = space_search_var(current_space, variable->name, 0);
if (cvar != NULL) {
    int num = 0;
    // Check if cvar if function
    if (variable->type->stype->func != NULL && cvar->type->stype->func != NULL) {
        int showAll = 0;
        for (; cvar != NULL; cvar = cvar->next) {
            num += 1;
            if (!showAll) {
                int result = func_compare(variable->type->stype->func, cvar->type->stype->func);
                if (result == 1) {
                    error(FUNC_TYPE_NOT_MATCH, merge(6,
                        "Function ",
                        token(cvar->name),
                        " already define by type ",
                        token(cvar->type->stype->func->return_type->code),
                        ", cannot match with ",
                        token(variable->type->stype->func->return_type->code)), variable->location);
                    note(merge(3, "Function ", token(cvar->name), " was define here"), cvar->location);
                    showAll = 1;
                } else if (result == 0) {
                    error(SAME_FUNC_PARAM_ALREADY_EXIST, merge(3, "Same function param with ", token(variable->name), " already exist"), variable->location);
                    note(merge(3, "Same function ", token(cvar->name), " was define here"), cvar->location);
                    return 0;
                }
            } else {
                note(merge(3, "Function ", token(cvar->name), " was define here"), cvar->location);
            }
        }
        if (showAll) return 0;
        else {
            variable->gname = merge(3, variable->gname, "_$", itoc(num));
            if (for_init) current_space->init_variables = var_push(current_space->init_variables, variable);
            else current_space->variables = var_push(current_space->variables, variable);
            debug(merge(4, "Define multiple function ", token(variable->name), " type ", token(variable->type->code)), variable->location);
            return 1;
        }
    }
    error(VAR_ALREADY_EXIST, merge(3, "Variable ", token(variable->name), " already exist"), variable->location);
    note(merge(3, "Variable ", token(cvar->name), " was define here"), cvar->location);
    return 0;
} else {
    if (for_init) current_space->init_variables = var_push(current_space->init_variables, variable);
    else current_space->variables = var_push(current_space->variables, variable);
    debug(merge(4, "Define variable ", token(variable->name), " type ", token(variable->type->code)), variable->location);
    return 1;
}
