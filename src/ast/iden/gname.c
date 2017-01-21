if (target == NULL || target->attach == NULL) return target->gname;
return target->attach->gname;
