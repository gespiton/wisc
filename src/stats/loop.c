if (!current_space->loop) {
    if (type) error(CONTINUE_NOT_ALLOW_HERE, "Continue not allow here", current_location);
    else error(BREAK_NOT_ALLOW_HERE, "Break not allow here", current_location);
    return "";
}

return "";
