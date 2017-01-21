// Pass very variable assign with void type
if (strcmp(right->name, TYPE_VOID) == 0) return 1;

// left is number
if (strcmp(left->name, TYPE_NUMBER) == 0 &&
    (strcmp(right->name, TYPE_INT) == 0 || strcmp(right->name, TYPE_BOOLEAN) == 0)) return 1;
// left is int
if (strcmp(left->name, TYPE_INT) == 0 && strcmp(right->name, TYPE_BOOLEAN) == 0) return 1;

// Compare two function
if (left->stype->func != NULL && right->stype->func != NULL)
    if (!func_compare(left->stype->func, right->stype->func)) return 1;

// Compare two type name
if (strcmp(left->code, right->code) == 0) return 1;


return 0;
