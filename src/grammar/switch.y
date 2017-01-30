defineSwitch:
SWITCH LPAREN expr RPAREN {
    if (parsing_step == DEFINE) space_create();
    else if (parsing_step == STAT) {
        space_next();
        if ($3 == NULL) current_space->lock = 1;
        else space_header(current_space, merge(3, "switch (", $3->value, ")"));
    }
} switchSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT && !current_space->lock)
            space_context(current_space->parent, space_generate(current_space), 1);
        space_end();
    }
}
;

switchSpace:
LBRACE switchStats RBRACE { ; }
| endls switchSpace { ; }
;

switchStats:
switchStats switchStat { ; }
| switchStat { ; }
;

switchStat: { ; }
| endls { ; }
| CASE LPAREN expr RPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) {
        space_next();
        if ($3 == NULL) current_space->lock = 1;
        else space_header(current_space, concat("case ", $3->value));
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT && !current_space->lock)
            space_context(current_space->parent, space_generate_switch(current_space), 1);
        space_end();
    }
}
| DEFAULT {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) {
        space_next();
        space_header(current_space, "default");
    }
} subSpace {
    if (parsing_step < TYPE) {
        if (parsing_step == STAT && !current_space->lock)
            space_context(current_space->parent, space_generate_switch(current_space), 1);
        space_end();
    }
}
;
