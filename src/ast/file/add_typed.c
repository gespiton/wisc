// Search if variable name already exists as structure
if (file_search_structure(current_file, typede->name) != NULL) {
    error(STRUCTURE_ALREADY_EXISTS, merge(3, "Identifier ", token(typede->name), " already exist as structure"), typede->location);
    return;
}

// Search if typed name already exists in file
typed* ctd = file_search_typed(target, typede->name);
if (ctd != NULL) {
    error(TYPEDEF_ALREADY_EXISTS, merge(3, "Identifier ", token(typede->name), " already exists as typed"), typede->location);
    note(merge(3, "Typedef ", token(ctd->name), " was defined here"), ctd->location);
    return;
}
target->typeds = typed_push(target->typeds, typede);
