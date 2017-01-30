assignment: { $$ = NULL; }
| defineIden ASSIGN expr {
    if (parsing_step == STAT) $$ = stat_assignment($1, $3);
    else $$ = NULL;
}
;

iteration:
assignment { $$ = $1; }
| idenFunc {
    if ($1 != NULL && parsing_step == STAT) {
        char* string = concat(iden_gname($1), ";");
        space_context(current_space, string, 1);
    }
}
;
