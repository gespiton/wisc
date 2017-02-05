if (left == NULL || right == NULL) return NULL;

# new nexpr name merge(3,left->name,symbol,right->name) value merge(3,left->value,symbol,right->value)
if (nexpr != NULL) {
    nexpr->value = merge(5, left->value, " ", symbol, " ", right->value);
    nexpr->location = location_plus(left->location, right->location);
}

nexpr->type = type_multiple(left->type, right->type);
if (nexpr->type->multiple != NULL) {
    nexpr->type->name = merge(3, "(", nexpr->type->name, ")");
}

return nexpr;
