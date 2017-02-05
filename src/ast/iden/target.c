if (target == NULL) return NULL;
type* ctype = target->type;
for (; ctype != NULL; ctype = ctype->multiple) {
    if (strcmp(ctype->code, deft->code) == 0) {
        target->type = type_new(ctype);
        return target;
    }
}

if (ctype == NULL) {
    error(IDEN_TARGET_TYPE_FAILED, merge(3, token(iden_name(target)), " type not exists ", token(deft->name)), location_plus(target->location, location));
    return NULL;
}
return target;
