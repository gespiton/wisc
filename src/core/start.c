// Parse path
char* name;
parse_path(&main_path, &name, path);

// Add main file to waiting list then define it
waiting_file = list_create(name);
define_file();

// Define parsing
parsing_step = DEFINE;
parse_file(files_list);

// Statement parsing
parsing_step = STAT;
parse_file(files_list);
