defineVariale:
paramListP {
    if (parsing_step == STAT) {
        param* cp = $1;
        for (; cp != NULL; cp = cp->next)
            error(1, merge(4, "Create ", cp->name, " type ", cp->type->name), cp->location);
    }
}
;
