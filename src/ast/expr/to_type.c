if (tlist == NULL) return NULL;

expr* cexpr = tlist;
type* ntype = NULL;
for (; cexpr != NULL; cexpr = cexpr->next)
    ntype = type_push(ntype, type_new(cexpr->type));
return ntype;
