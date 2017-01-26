if (symbol == NULL) return 0;
if (strcmp(symbol, "+") == 0 ||
    strcmp(symbol, "*") == 0 ||
    strcmp(symbol, "==") == 0 ||
    strcmp(symbol, "!=") == 0)
    return 1;
else return 0;
