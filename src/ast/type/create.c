if (parsing_step > DEFINE) return NULL;
if (name == NULL) return NULL;

if (file_search_structure(current_file, name->name) == NULL) {
    if (parsing_step < TYPE)
        error(UNKNOWN_TYPE_ERROR, concat("Unknown type ", token(name->name)), name->location);
    return NULL;
}

if (stype != NULL) {
    if (strcmp(name->name, TYPE_FUNCTION) == 0 && stype->func == NULL) {
        error(DEFINE_FUNC_TYPE_FAILED, "Define a variable function type incorrect", name->location);
        note(concat("To define variable function ", token("{function type}( {param type list} )")), NULL);
        return NULL;
    }
} else stype = stype_blank();

# new ntype name name->name code name->name location name->location stype stype
return ntype;
