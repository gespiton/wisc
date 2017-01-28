defineIf:
ifPart { ; }
| ifPart elseIfParts { ; }
| ifPart elsePart { ; }
| ifPart elseIfParts elsePart { ; }
;

ifPart:
IF LPAREN expr RPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = current_space->parent->loop;
    } else if (parsing_step == STAT) {
        space_next();
        if ($3 == NULL) {
            current_space->lock = 1;
        }
    }
} subSpace {
    space_end();
}
;

elseIfParts:
elseIfParts elseIfPart { ; }
| elseIfPart { ; }

elseIfPart:
ELSE IF LPAREN expr RPAREN {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = current_space->parent->loop;
    } else if (parsing_step == STAT) {
        space_next();
        if ($4 == NULL) current_space->lock = 1;
    }
} subSpace {
    space_end();
}
;

elsePart:
ELSE {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = current_space->parent->loop;
    } else if (parsing_step == STAT) space_next();
} subSpace {
    space_end();
}
;
