defineParam:
defineType name { $$ = param_create($2, $1, NULL); }
| defineType name ASSIGN expr { $$ = param_create($2, $1, $4); }
;

paramListP:
paramListP list defineParam { $$ = param_push($1, $3); }
| defineParam { $$ = $1; }
;

paramList: { $$ = NULL; }
| paramListP { $$ = $1; }
;
