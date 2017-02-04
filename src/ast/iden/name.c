if (target == NULL) return "";
if (target->attach == NULL) return target->name;
return target->attach->name;
