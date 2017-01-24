if (parsing_step != STAT) return NULL;
// Check current space variable
var* cvar = space_search_var(current_space, name->name, 1);
if (cvar == NULL) {
    error(UNKNOWN_IDEN, concat("Unknown identifier ", token(name->name)), name->location);
    return NULL;
}

# new niden name name->name type cvar->type location name->location attach cvar
return niden;
