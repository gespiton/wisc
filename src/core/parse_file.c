if (cfile == NULL) return;
// Open file
FILE* scriptFile = fopen(merge(3, main_path, cfile->name, ".wis"), "r");
if (!scriptFile) return;

current_file = cfile;
yyin = scriptFile;
yyrestart(yyin);

// Init new file
line_number = 1;
col_number = 1;

do {
    yyparse();
} while( !feof(yyin) );

if (cfile->next != NULL) parse_file(cfile);
