if (target == NULL) return NULL;

operator* copt = main_operator;
operator* result = NULL;
int iscom = operator_is_commutative(target->symbol);
for (; copt != NULL; copt = copt->next) {
    if (strcmp(target->symbol, copt->symbol) == 0) {
        if (type_compare(copt->left, target->left) &&
            type_compare(copt->right, target->right))
            result = copt;
        else if (iscom && type_compare(copt->left, target->right) &&
            type_compare(copt->right, target->left))
            result = copt;
    }
}

return result;
