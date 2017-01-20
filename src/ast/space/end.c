if (current_space->parent == NULL) return;
current_space->current_child = current_space->children;
current_space = current_space->parent;
