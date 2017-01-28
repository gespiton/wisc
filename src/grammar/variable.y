defineVariale:
paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next)
            space_add_var(var_create(cp));
    } else if (parsing_step == STAT) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next) {
            var* cvar = space_search_var(current_space, cp->name, 0);
            if (cvar != NULL && cp->expr != NULL)
                cvar->expr = cp->expr;
        }
    }
}
| CONST paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $2;
        for (; cp != NULL; cp = cp->next) {
            var* nvar = var_create(cp);
            nvar->read_only = 1;
            space_add_var(nvar);
        }
    } else if (parsing_step == STAT) {
        param* cp = $2;
        for (; cp != NULL; cp = cp->next) {
            var* cvar = space_search_var(current_space, cp->name, 0);
            if (cvar != NULL && cp->expr != NULL)
                cvar->expr = cp->expr;
        }
    }
}
;
