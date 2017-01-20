if (location != NULL)
    printf("%s:%d:%d.%d:%s %s\n", current_file->name, location->fl, location->fc, location->lc, type, msg);
else printf("%s:%d:%s %s\n", current_file->name, line_number, type, msg);
return 1;
