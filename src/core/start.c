// Parse path
char* name;
parse_path(&main_path, &name, path);

if (option_step) printf("%s\n", COLOR_WARNING "Type parsing\x1b[0m");
// Add main file to waiting list then define it
waiting_file = list_create(name);
define_file();

if (option_step) printf("%s\n", COLOR_WARNING "Define parsing\x1b[0m");
// Define parsing
parsing_step = DEFINE;
parse_file(files_list);

if (option_step) printf("%s\n", COLOR_WARNING "Statement parsing\x1b[0m");
// Statement parsing
parsing_step = STAT;
parse_file(files_list);
