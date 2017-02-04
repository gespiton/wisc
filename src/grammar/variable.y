defineVariale:
paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next)
            space_add_var(var_create(cp), 0);
    } else if (parsing_step == STAT) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next) {
            var* cvar = space_search_var(current_space, cp->name, 0);
            if (cvar != NULL && cp->expr != NULL) {
                if (!type_compare(cvar->type, cvar->type, cp->expr->type)) {
                    error(VAR_CANNOT_MATCH,
                        merge(6, "Variable ", token(cvar->name), " type ", token(cvar->type->name), " cannot match with ", token(cp->expr->type->name)),
                        location_plus(cvar->location, cp->expr->location));
                    continue;
                }
                space_context(current_space, merge(4, cvar->gname, " = ", cp->expr->value, ";"), 1);
            }
        }
    }
}
| CONST paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $2;
        for (; cp != NULL; cp = cp->next) {
            var* nvar = var_create(cp);
            nvar->read_only = 1;
            space_add_var(nvar, 0);
        }
    } else if (parsing_step == STAT) {
        param* cp = $2;
        for (; cp != NULL; cp = cp->next) {
            var* cvar = space_search_var(current_space, cp->name, 0);
        }
    }
}
;
