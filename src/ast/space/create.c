# new nspace
if (current_space != NULL) {
    nspace->parent = current_space;
    nspace->func = nspace->parent->func;
    if (current_space->children != NULL)
        nspace->id = current_space->children->length;
    # push current_space->children nspace cspace
    current_space->current_child = nspace;
    current_space = nspace;
}
return nspace;
