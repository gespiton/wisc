if (tlist == NULL) return NULL;
type* ctype = tlist;
char* return_string = "";
for (; ctype != NULL; ctype = ctype->next)
    return_string = merge(3, return_string, ",", ctype->code);
return &return_string[1];
