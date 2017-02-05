typed* ctyped = target->typeds;
for (; ctyped != NULL; ctyped = ctyped->next) {
    if (strcmp(ctyped->name, name) == 0)
        return ctyped;
}
return NULL;
