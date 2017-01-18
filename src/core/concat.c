if (string1 == NULL || string2 == NULL) return "";
char* result = (char*)malloc(strlen(string1) + strlen(string2) + 1);
strcpy(result, string1);
strcat(result, string2);
return result;
