if (target == NULL || target->parent == NULL) return 0;
int counting = 0;
space* cspace = target->parent;
for (; cspace != NULL; cspace = cspace->parent)
    counting += 1;
return counting;
