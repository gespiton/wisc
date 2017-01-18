char *slash = pf, *next;
while ((next = strpbrk(slash + 1, "\\/"))) slash = next;
if (pf != slash) slash++;
*p = strndup(pf, slash - pf);
*f = strdup(slash);
