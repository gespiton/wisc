if (location != NULL)
    printf("\x1b[36m%s:%d:%d.%d:\x1b[0m%s %s\n", current_file->name, location->fl, location->fc, location->lc, type, msg);
else printf("\x1b[36m%s:%d:\x1b[0m%s %s\n", current_file->name, line_number, type, msg);
return 1;
