if (target == NULL) return NULL;
structure* nstructure = (structure*)malloc(sizeof(structure));
memcpy(nstructure, target, sizeof(structure));
nstructure->next = NULL;
return nstructure;
