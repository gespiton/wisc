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
                if (cp->expr != NULL) {
                    if (type_compare(cp->type, cp->expr->type))
                        output("", merge(6, "Create ", cp->name, " type ", cp->type->code, " value ", cp->expr->value), location_plus(cp->location, cp->expr->location));
                    else {
                        error(VAR_CANNOT_MATCH,
                            merge(6, "Variable ", token(cp->name), " type ", token(cp->type->code), " cannot match with ", token(cp->expr->type->code)),
                            cp->location);
                    }
                } else output("", merge(4, "Create ", cp->name, " type ", cp->type->code), cp->location);
            }
        }
    }
}
;
