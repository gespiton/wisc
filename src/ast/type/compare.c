// Pass very variable assign with void type
if (strcmp(right->name, TYPE_VOID) == 0) return 1;

// left is number
if (strcmp(left->name, TYPE_NUMBER) == 0 &&
    (strcmp(right->name, TYPE_INT) == 0 || strcmp(right->name, TYPE_BOOLEAN) == 0)) return 1;
// left is int
if (strcmp(left->name, TYPE_INT) == 0 && strcmp(right->name, TYPE_BOOLEAN) == 0) return 1;

// Compare two type name
if (strcmp(left->name, right->name) == 0) return 1;

return 0;
