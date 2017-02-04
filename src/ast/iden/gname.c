if (target == NULL) return "";
if (target->attach == NULL) return concat(target->gname, target->bracket);
return concat(target->attach->gname, target->bracket);
