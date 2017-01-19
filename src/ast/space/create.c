# new nspace
if (current_space != NULL) {
    nspace->parent = current_space;
    nspace->id = nspace->parent->children->length;
    # push current_space->children nspace cspace
    current_space->current_child = nspace;
    current_space = nspace;
} else current_space = nspace;
return nspace;
