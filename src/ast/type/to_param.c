if (parsing_step > DEFINE || tlist == NULL) return NULL;
type* ctype = tlist;
param* nparam = NULL;
for (; ctype != NULL; ctype = ctype->next) {
    nparam = param_push(nparam, param_create(string_create(""), type_new(ctype), NULL));
    nparam->location = ctype->location;
}
return nparam;
