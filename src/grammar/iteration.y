assignment:
defineIden ASSIGN expr {
    if (parsing_step == STAT) stat_assignment($1, $3);
}
;

iteration:
assignment { ; }
;
