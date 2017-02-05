if (return_type == NULL) return NULL;

# new nfunc return_type return_type params_list params_list
if (strcmp(return_type->code, TYPE_VOID) == 0 ||
    strcmp(return_type->code, TYPE_ANY) == 0)
    nfunc->have_return = 1;
return nfunc;
