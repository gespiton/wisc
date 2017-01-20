// Parse path
char* name;
parse_path(&main_path, &name, path);

printf("%s\n", "Type parsing");
// Add main file to waiting list then define it
waiting_file = list_create(name);
define_file();

printf("%s\n", "Define parsing");
// Define parsing
parsing_step = DEFINE;
parse_file(files_list);

printf("%s\n", "Statement parsing");
// Statement parsing
parsing_step = STAT;
parse_file(files_list);
