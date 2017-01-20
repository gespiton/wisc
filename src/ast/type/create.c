if (parsing_step > DEFINE) return NULL;
if (name == NULL) return NULL;

if (file_search_structure(current_file, name->name) == NULL) {
    if (parsing_step == STAT) error(UNKNOWN_TYPE_ERROR, concat("Unknown type ", token(name->name)), name->location);
    return NULL;
}

# new ntype name name->name code name->name location name->location
return ntype;
