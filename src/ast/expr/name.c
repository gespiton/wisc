if (elist == NULL) return "";
expr* cexpr = elist;
char* return_string = "";
for (; cexpr != NULL; cexpr = cexpr->next)
    return_string = merge(3, return_string, ",", cexpr->name);
return &return_string[1];
