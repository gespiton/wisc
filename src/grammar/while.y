defineWhile:
WHILE LPAREN expr RPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) {
        space_next();
        if ($3 == NULL) current_space->lock = 1;
        else space_header(current_space, merge(3, "while (", $3->value, ")"));
    }
} subSpace {
    if (parsing_step == STAT && !current_space->lock)
        space_context(current_space->parent, space_generate(current_space), 1);
    if (parsing_step < TYPE)
        space_end();
}
