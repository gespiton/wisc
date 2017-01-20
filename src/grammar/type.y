defineType:
name { $$ = type_create($1, stype_blank()); }
;

typeListP:
typeListP list defineType { $$ = type_push($1, $3); }
| defineType { $$ = $1; }
;

typeList: { $$ = NULL; }
| typeListP { $$ = $1; }
;
