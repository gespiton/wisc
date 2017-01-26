if (target == NULL) return NULL;

operator* copt = main_operator;
operator* result = NULL;
int iscom = operator_is_commutative(target->symbol);
for (; copt != NULL; copt = copt->next) {
    if (strcmp(target->symbol, copt->symbol) == 0) {
        if (strcmp(copt->left->code, target->left->code) == 0 &&
            strcmp(copt->right->code, target->right->code) == 0)
            result = copt;
        else if (iscom && strcmp(copt->left->code, target->right->code) == 0 &&
            strcmp(copt->right->code, target->left->code) == 0)
            result = copt;
    }
}

return result;
