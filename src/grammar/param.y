defineParam:
defineType name { $$ = param_create($2, $1); }
;

paramListP:
paramListP list defineParam { $$ = param_push($1, $3); }
| defineParam { $$ = $1; }
;
