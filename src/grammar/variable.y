defineVariale:
paramListP {
    if (parsing_step == DEFINE) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next)
            space_add_var(var_create(cp));
    } else if (parsing_step == STAT) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next) {
            if (space_add_var(var_create(cp))) {
                if (cp->expr != NULL)
                    output("", merge(6, "Create ", cp->name, " type ", cp->type->code, " value ", cp->expr->value), location_plus(cp->location, cp->expr->location));
                else output("", merge(4, "Create ", cp->name, " type ", cp->type->code), cp->location);
            }
        }
    }
}
;
