if (plist == NULL) return NULL;

param* cp = plist;
type* ntype = NULL;
for (; cp != NULL; cp = cp->next)
    ntype = type_push(ntype, type_new(cp->type));
return ntype;
