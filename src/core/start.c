init();

// Init file
if (option_step) printf("%s\n", COLOR_WARNING "Init rule\x1b[0m");
FILE* initFile = fopen("init.wis", "r");
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

// Parse path
char* name;
parse_path(&main_path, &name, path);

if (option_step) printf("%s\n", COLOR_WARNING "Type parsing\x1b[0m");
// Add main file to waiting list then define it
parsing_step = TYPE;
waiting_file = list_create(name);
define_file();


if (option_step) printf("%s\n", COLOR_WARNING "Define parsing\x1b[0m");
parsing_step = DEFINE;
// Define parsing
parse_file(files_list);

if (option_step) printf("%s\n", COLOR_WARNING "Statement parsing\x1b[0m");
// Statement parsing
parsing_step = STAT;
parse_file(files_list);

// Generate

// Write file
if (!error_number) {
    printf("%s%s%s%s%s%s\n", TEMPLATE_DEBUG_HEADER, "\n", TEMPLATE_DEBUG_FOOTER, "\n", space_generate(files_list->main_space), "\n])");

    FILE* generationFile = fopen("main.js", "wb");
    fprintf(generationFile, "%s%s%s%s%s%s\n", TEMPLATE_DEBUG_HEADER, "\n", TEMPLATE_DEBUG_FOOTER, "\n", space_generate(files_list->main_space), "\n])");
    fclose(generationFile);
}
