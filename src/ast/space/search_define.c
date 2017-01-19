var* cvar = target->defines;
for (; cvar != NULL; cvar = cvar->next)
    if (strcmp(cvar->name, name) == 0)
        return cvar;

if (cvar == NULL && search_parent && target->parent != NULL)
    return space_search_var(target->parent, name, 1);
else return NULL;
