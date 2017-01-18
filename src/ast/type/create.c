if (parsing_step == TYPE) return NULL;
if (name == NULL) return NULL;

if (file_search_structure(current_file, name->name) == NULL) {
    if (parsing_step == STAT) error(UNKNOW_TYPE_ERROR, merge(3, "Unknow type '", name->name, "'"), name->location);
    return NULL;
}

# new ntype name name->name code name->name location name->location
return ntype;
