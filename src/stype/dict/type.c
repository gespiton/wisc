if (atype == NULL || parsing_step == TYPE) return NULL;
# new ndict type atype
type* ntype = type_create(string_create(TYPE_DICT), stype_dict(ndict));
ntype->code = merge(3, "{", atype->name, "}");
ntype->name = ntype->code;
return ntype;
