if (otype == NULL) return NULL;
type* ntype = (type*)malloc(sizeof(type));
memcpy(ntype, otype, sizeof(type));
ntype->next = NULL;
return ntype;
