if (left == NULL || right == NULL) return 0;
int passing = 0;
if (left != NULL && generate_left == NULL)
    generate_left = left;

// Pass very variable assign with left any type
if (strcmp(left->code, TYPE_ANY) == 0 ||
    strcmp(right->code, TYPE_ANY) == 0)
    passing = 1;
// Pass very variable assign with void type
if (strcmp(right->code, TYPE_VOID) == 0) passing = 1;

// left is number
if (strcmp(left->code, TYPE_NUMBER) == 0 &&
    (strcmp(right->code, TYPE_INT) == 0 || strcmp(right->code, TYPE_BOOLEAN) == 0)) passing = 1;
// left is int
if (strcmp(left->code, TYPE_INT) == 0 && strcmp(right->code, TYPE_BOOLEAN) == 0) passing = 1;

// Compare two function
if (left->stype->func != NULL && right->stype->func != NULL)
    if (!func_compare(left->stype->func, right->stype->func)) passing = 1;
// Compare two array
if (left->stype->array != NULL && right->stype->array != NULL)
    passing = type_compare(left->stype->array->type, left->stype->array->type, right->stype->array->type);
// Compare two dictionary
if (left->stype->dict != NULL && right->stype->dict != NULL)
    passing = type_compare(left->stype->dict->type, left->stype->dict->type, right->stype->dict->type);

// Compare two type name
if (strcmp(left->code, right->code) == 0)
    passing = 1;

if (!passing && left->multiple != NULL)
    passing = type_compare(left->multiple, generate_left, right);
if (!passing && right->multiple != NULL)
    passing = type_compare(generate_left, generate_left, right->multiple);

return passing;
