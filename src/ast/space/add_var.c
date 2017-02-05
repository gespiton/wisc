if (parsing_step != DEFINE) return 0;
if (variable == NULL) return 0;

// Search if variable name already exists as structure
if (file_search_structure(current_file, variable->name) != NULL) {
    error(STRUCTURE_ALREADY_EXISTS, merge(3, "Identifier ", token(variable->name), " already exist as structure"), variable->location);
    return 0;
}
// Search if variable name already exists as typedef
typed* ctd = file_search_typed(current_file, variable->name);
if (ctd != NULL) {
    error(TYPEDEF_ALREADY_EXISTS, merge(3, "Identifier ", token(variable->name), " already exist as typedef"), variable->location);
    note(merge(3, "Typedef ", token(ctd->name), " was defined here"), ctd->location);
    return 0;
}

// Search if variable name already exists
var* cvar = space_search_var(current_space, variable->name, 0);
if (cvar != NULL) {
    int num = 0;
    // Check if cvar if function
    if (variable->type->stype->func != NULL && cvar->type->stype->func != NULL) {
        for (; cvar != NULL; cvar = cvar->next) {
            num += 1;
            int result = func_compare(variable->type->stype->func, cvar->type->stype->func);
            if (result == 0) {
                error(SAME_FUNC_PARAM_ALREADY_EXIST, merge(3, "Same function param with ", token(variable->name), " already exist"), variable->location);
                note(merge(3, "Same function ", token(cvar->name), " was define here"), cvar->location);
                return 0;
            }
        }

        variable->gname = merge(3, variable->gname, "_$", itoc(num));
        if (for_init) current_space->init_variables = var_push(current_space->init_variables, variable);
        else current_space->variables = var_push(current_space->variables, variable);
        debug(merge(4, "Define multiple function ", token(variable->name), " type ", token(variable->type->name)), variable->location);
        return 1;
    }
    error(VAR_ALREADY_EXIST, merge(3, "Variable ", token(variable->name), " already exist"), variable->location);
    note(merge(3, "Variable ", token(cvar->name), " was define here"), cvar->location);
    return 0;
} else {
    if (for_init) current_space->init_variables = var_push(current_space->init_variables, variable);
    else current_space->variables = var_push(current_space->variables, variable);
    debug(merge(4, "Define variable ", token(variable->name), " type ", token(variable->type->name)), variable->location);
    return 1;
}
