if (ovar == NULL) return NULL;
var* nvar = (var*)malloc(sizeof(var));
memcpy(nvar, ovar, sizeof(var));
nvar->next = NULL;
return nvar;
