var* cvar = target->variables;
var* rvar = NULL;
for (; cvar != NULL; cvar = cvar->next)
    if (strcmp(cvar->name, name) == 0)
        rvar = var_push(rvar, var_new(cvar));

if (rvar == NULL && search_parent && target->parent != NULL)
    return space_search_var(target->parent, name, 1);
else return rvar;
