structure* cstructure = target->structures;
for (; cstructure != NULL; cstructure = cstructure->next) {
    if (strcmp(cstructure->name, name) == 0)
        return cstructure;
}
return NULL;
