defineWhile:
WHILE LPAREN expr RPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) {
        space_next();
        if ($3 == NULL) current_space->lock = 1;
    }
} subSpace {
    if (parsing_step < TYPE)
        space_end();
}
