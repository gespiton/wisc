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
                            merge(7, "Variable \x1b[35m'", cp->name, "'\x1b[0m type \x1b[35m'", cp->type->code, "'\x1b[0m cannot match with \x1b[35m'", cp->expr->type->code, "'\x1b[0m"),
                            cp->location);
                    }
                } else output("", merge(4, "Create ", cp->name, " type ", cp->type->code), cp->location);
            }
        }
    }
}
;
