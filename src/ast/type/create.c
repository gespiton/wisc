if (name == NULL) return NULL;

if (file_search_structure(current_file, name->name) == NULL) {
    if (parsing_step == STAT)
        error(UNKNOWN_TYPE_ERROR, concat("Unknown type ", token(name->name)), name->location);
    return NULL;
}

if (stype != NULL) {
    if (strcmp(name->name, TYPE_FUNCTION) == 0 && stype->func == NULL) {
        if (parsing_step == STAT) {
            error(DEFINE_FUNC_TYPE_FAILED, "Define a variable function type incorrect", name->location);
            note(concat("To define variable function ", token("<function type>:(<param type list>)")), NULL);
        }
        return NULL;
    }

    if (strcmp(name->name, TYPE_ARRAY) == 0 && stype->array == NULL) {
        if (parsing_step == STAT) {
            error(DEFINE_ARRAY_TYPE_FAILED, "Define a variable array type incorrect", name->location);
            note(concat("To define variable array ", token("<array type>[]")), NULL);
        }
        return NULL;
    }

    if (strcmp(name->name, TYPE_DICT) == 0 && stype->dict == NULL) {
        if (parsing_step == STAT) {
            error(DEFINE_DICT_TYPE_FAILED, "Define a variable dictionary type incorrect", name->location);
            note(concat("To define variable dictionary ", token("{<dictionary type>}")), NULL);
        }
        return NULL;
    }
} else stype = stype_blank();

# new ntype name name->name code name->name location name->location stype stype
return ntype;
