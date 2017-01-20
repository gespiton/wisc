if (parsing_step > DEFINE) return 0;
if (variable == NULL) return 0;

// Search if variable name already exists
var* cvar = space_search_define(current_space, variable->name, 0);
if (parsing_step == DEFINE) {
    if (cvar != NULL) {
        error(VAR_ALREADY_EXIST, merge(3, "Variable ", token(variable->name), " already exist"), variable->location);
        note(merge(3, "Variable ", token(cvar->name), " was define here"), cvar->location);
        return 0;
    } else {
        current_space->defines = var_push(current_space->defines, variable);
        return 1;
    }
} else if (parsing_step == STAT) {
    if (cvar != NULL && space_search_var(current_space, variable->name, 0) == NULL) {
        var* nvar = (var*)malloc(sizeof(var));
        memcpy(nvar, cvar, sizeof(var));
        nvar->next = NULL;
        current_space->variables = var_push(current_space->variables, nvar);
        return 1;
    } else return 0;
} else return 0;
