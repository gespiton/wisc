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
        if ($3 == NULL) current_space->lock = 1;
        else space_header(current_space, merge(4, "if ", "(", $3->value, ")"));
    }
} subSpace {
    if (parsing_step == STAT && !current_space->lock)
        space_context(current_space->parent, space_generate(current_space), 1);
    if (parsing_step < TYPE)
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
        else space_header(current_space, merge(4, "else if ", "(", $4->value, ")"));
    }
} subSpace {
    if (parsing_step == STAT && !current_space->lock)
        space_context(current_space->parent, space_generate(current_space), 0);
    if (parsing_step < TYPE)
        space_end();
}
;

elsePart:
ELSE {
    if (parsing_step == DEFINE) {
        space_create();
        current_space->loop = current_space->parent->loop;
    } else if (parsing_step == STAT) {
        space_next();
        space_header(current_space, "else");
    }
} subSpace {
    if (parsing_step == STAT && !current_space->lock)
        space_context(current_space->parent, space_generate(current_space), 0);
    if (parsing_step < TYPE)
        space_end();
}
;
