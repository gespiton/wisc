if (atype == NULL || parsing_step == TYPE) return NULL;
# new narray type atype
type* ntype = type_create(string_create(TYPE_ARRAY), stype_array(narray));
ntype->code = concat(atype->name, "[]");
ntype->name = ntype->code;
return ntype;
