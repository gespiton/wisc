assignment:
defineIden ASSIGN expr {
    if ($1 != NULL && $3 != NULL) {
        output("", merge(4, "Assignment '", iden_name($1), "' for ", $3->value), location_plus($1->location, $3->location));
    }
}
;
