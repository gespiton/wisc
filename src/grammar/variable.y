defineVariale:
paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next) {
            space_add_var(var_create(cp));
        }
    }
    else if (parsing_step == STAT) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next) {
            if (space_search_var(current_space, cp->name, 0) != NULL)
                if (cp->expr != NULL) {
                    var* cvar = space_search_var(current_space, cp->name, 0);
                    if (cvar != NULL) cvar->expr = cp->expr;
                }
        }
    }
}
;
