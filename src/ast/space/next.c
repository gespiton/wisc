if (current_space->current_child == NULL) return;
current_space = current_space->current_child;
if (current_space->next != NULL)
    current_space->parent->current_child = current_space->next;
