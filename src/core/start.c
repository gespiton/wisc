
// Parse path
char* name;
parse_path(&main_path, &name, path);

if (option_step) printf("%s\n", COLOR_WARNING "Type parsing\x1b[0m");
// Add main file to waiting list then define it
parsing_step = TYPE;
waiting_file = list_create(name);
define_file();

// Init file
parsing_step = DEFINE;
FILE* initFile = fopen("init.wis", "r");
current_file = files_list;
line_number = 1;
col_number = 1;
if (!initFile) {
    error(CANNOT_LOAD_INIT, "Cannot read init file", NULL);
    exit(-1);
}
yyin = initFile;
yyrestart(yyin);
do {
    yyparse();
} while(!feof(yyin));

if (option_step) printf("%s\n", COLOR_WARNING "Define parsing\x1b[0m");
// Define parsing
parse_file(files_list);

if (option_step) printf("%s\n", COLOR_WARNING "Statement parsing\x1b[0m");
// Statement parsing
parsing_step = STAT;
parse_file(files_list);
