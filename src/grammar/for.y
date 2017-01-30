defineFor:
FOR LPAREN paramList {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
        // Add initiaze vars
        if ($3 != NULL) {
            param* cp = $3;
            for (; cp != NULL; cp = cp->next)
                space_add_var(var_create(cp), 1);
        }
    } else if (parsing_step == STAT) {
        space_next();
    }
} SEMICOLON expr SEMICOLON iteration RPAREN {
    if (parsing_step == STAT && !current_space->lock) {
        char* string = "for (";
        if ($3 != NULL) {
            string = concat(string, "var ");
            param* cp = $3;
            for (; cp != NULL; cp = cp->next) {
                var* cvar = space_search_var(current_space, cp->name, 0);
                if (cvar != NULL) {
                    string = concat(string, cvar->gname);
                    if (cp->expr != NULL) {
                        string = merge(3, string, " = ", cp->expr->value);
                    }
                    if (cp->next != NULL) {
                        string = concat(string, ", ");
                    }
                }
            }
            string = concat(string, "; ");
        }
        if ($8 != NULL) {
            long len = strlen($8) - 1;
            memmove(&$8[len], &$8[len + 1], strlen($8) - len);
            string = merge(5, string, $6->value, "; ", $8, ")");
        } else string = merge(3, string, $6->value, ";)");
        space_header(current_space, string);
        current_space->context = "";
    }
} subSpace {
    if (parsing_step == STAT && !current_space->lock)
        space_context(current_space->parent, space_generate(current_space), 1);
    if (parsing_step < TYPE)
        space_end();
}
