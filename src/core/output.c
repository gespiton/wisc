if (location != NULL && location->fl == location->ll)
    printf("%s:%d:%d.%d:%s %s\n", current_file->name, location->fl, location->fc, location->lc, type, msg);
else if (location != NULL && location->fl != location->ll)
    printf("%s:%d:%d.%d:%d:%s %s\n", current_file->name, location->fl, location->fc, location->ll, location->lc, type, msg);
else if (line_number) printf("%s:%d:%s %s\n", current_file->name, line_number, type, msg);
else if (current_file != NULL) printf("%s:%s %s\n", current_file->name, type, msg);
else if (current_file == NULL) printf("%s %s\n", type, msg);
return 1;
