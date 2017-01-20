char* type = merge(3, COLOR_ERROR " error:", itoc(code), ":\x1b[0m");
output(type, msg, location);
return 1;
