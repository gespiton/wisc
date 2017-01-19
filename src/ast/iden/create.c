if (parsing_step != STAT) return NULL;

// Check current space variable
var* cvar = space_search_var(current_space, name->name, 1);
if (cvar == NULL) {
    error(UNKNOWN_IDEN, merge(3, "Unknown identifier \x1b[35m'", name->name, "'\x1b[0m"), name->location);
    return NULL;
}

# new niden name name->name type cvar->type location name->location attach cvar
return niden;
