defineFor:
FOR RPAREN paramList {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
        // Add initiaze vars
        if ($3 != NULL) {
            param* cp = $3;
            for (; cp != NULL; cp = cp->next)
                space_add_var(var_create(cp));
        }
    } else if (parsing_step == STAT) {
        space_next();
    }
} SEMICOLON expr SEMICOLON iteration LPAREN subSpace {
    if (parsing_step < TYPE)
        space_end();
}
