if (parsing_step > DEFINE) return NULL;
if (type == NULL || name == NULL) return NULL;

# new nparam name name->name type type expr expr location location_plus(type->location,name->location)
return nparam;
