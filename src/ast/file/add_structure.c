// Search if structure name already exists in file
if (file_search_structure(target, structure->name) != NULL) return;
// Push structure in to file structure list
structure_push(target->structures, structure);
