if (location != NULL)
    printf("%s:%d:%d.%d:error:%d: %s\n", current_file->name, line_number, location->fc, location->lc, code, msg);
else printf("%s:%d:error:%d: %s\n", current_file->name, line_number, code, msg);
return 1;
