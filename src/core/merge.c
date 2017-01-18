va_list list;
int j;
char* pchar = "";
va_start(list, length);
for(j = 0; j < length; j++) {
    char* nchar = va_arg(list, char*);
    if (pchar == NULL || nchar == NULL) return "";
    pchar = concat(pchar, nchar);
}
va_end(list);
return pchar;
