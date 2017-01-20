assignment:
defineIden ASSIGN expr {
    if ($1 != NULL && $3 != NULL) {
        if (type_compare($1->type, $3->type))
            output("", merge(4, "Assignment '", iden_name($1), "' for ", $3->value), location_plus($1->location, $3->location));
        else {
            error(VAR_CANNOT_MATCH,
                merge(6, "Variable ", token(iden_name($1)), " type ", token($1->type->code), " cannot match with ", token($3->type->code)),
                location_plus($1->location, $3->location));
            note(merge(3, "Variable ", token(iden_name($1)), " was define here"), $1->attach->location);
        }
    }
}
;
