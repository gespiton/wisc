FILE* scriptFile = fopen(merge(3, main_path, waiting_file->name, ".wis"), "r");

if (!scriptFile) {
    if (files_list == NULL) yyerror(concat("Cannot open main file ", waiting_file->name));
    waiting_file = waiting_file->next;
    return;
}

// Create new file
file* nfile = file_create(waiting_file->name);
if (files_list == NULL)
    files_list = nfile;
else file_push(files_list, nfile);
// Set current working file
current_file = nfile;

yyin = scriptFile;
yyrestart(yyin);

// Init new file
line_number = 1;
col_number = 1;
waiting_file = waiting_file->next;

do {
    yyparse();
} while(!feof(yyin));

// Continue define if there are more waiting file
if (waiting_file != NULL) define_file();
