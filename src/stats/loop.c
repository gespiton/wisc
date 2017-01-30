if (!current_space->loop) {
    if (type) error(CONTINUE_NOT_ALLOW_HERE, "Continue not allow here", current_location);
    else error(BREAK_NOT_ALLOW_HERE, "Break not allow here", current_location);
    return "";
}

if (type) space_context(current_space, "continue;", 1);
else space_context(current_space, "break;", 1);
return "";
