if (left == NULL || right == NULL) return NULL;

# new nexpr name merge(3,left->name,symbol,right->name) value merge(3,left->value,symbol,right->value)
nexpr->location = location_plus(left->location, right->location);

if (!type_compare(left->type, right->type)) {
    if (type_compare(right->type, left->type))
        nexpr->type = right->type;
    else return NULL;
} else nexpr->type = left->type;

return nexpr;
