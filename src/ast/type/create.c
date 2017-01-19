if (parsing_step > DEFINE) return NULL;
if (name == NULL) return NULL;

if (file_search_structure(current_file, name->name) == NULL) {
    if (parsing_step == STAT) error(UNKNOWN_TYPE_ERROR, merge(3, "Unknown type \x1b[35m'", name->name, "'\x1b[0m"), name->location);
    return NULL;
}

# new ntype name name->name code name->name location name->location
return ntype;
