assignment:
defineIden ASSIGN expr {
    if ($1 != NULL && $3 != NULL) {
        if (type_compare($1->type, $3->type))
            output("", merge(4, "Assignment '", iden_name($1), "' for ", $3->value), location_plus($1->location, $3->location));
        else {
            error(VAR_CANNOT_MATCH,
                merge(7, "Variable \x1b[35m'", iden_name($1), "'\x1b[0m type \x1b[35m'", $1->type->code, "'\x1b[0m cannot match with \x1b[35m'", $3->type->code, "'\x1b[0m"),
                location_plus($1->location, $3->location));
            note(merge(3, "Variable \x1b[35m'", iden_name($1), "'\x1b[0m was define here"), $1->attach->location);
        }
    }
}
;
