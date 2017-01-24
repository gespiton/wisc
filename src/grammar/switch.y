defineSwitch:
SWITCH RPAREN expr LPAREN {
    if (parsing_step == DEFINE) space_create();
    else if (parsing_step == STAT) space_next();
} switchSpace {
    if (parsing_step < TYPE) space_end();
}
;

switchSpace:
RBRACE switchStats LBRACE { ; }
| endls switchSpace { ; }
;

switchStats:
switchStats switchStat { ; }
| switchStat { ; }
;

switchStat: { ; }
| endls { ; }
| CASE RPAREN expr LPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) space_next();
} subSpace {
    if (parsing_step < TYPE) space_end();
}
| DEFAULT {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = 1;
    } else if (parsing_step == STAT) space_next();
} subSpace {
    if (parsing_step < TYPE) space_end();
}
;
