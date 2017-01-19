char* type = merge(3, " \x1b[31merror:", itoc(code), ":\x1b[0m");
output(type, msg, location);
return 1;
