defineType:
name { $$ = type_create($1, stype_blank()); }
| funcType { $$ = $1; }
| arrayType { $$ = $1; }
| dictType { $$ = $1; }
| LPAREN typeListM RPAREN {
    $$ = $2;
    if ($$ != NULL) {
        $$->name = merge(3, "(", $$->name, ")");
        $$->location = location_plus($1, $3);
    }
}
;

typeListM:
typeListM SOR defineType { $$ = type_multiple($1, $3); }
| defineType { $$ = $1; }
;

typeListP:
typeListP list defineType { $$ = type_push($1, $3); }
| defineType { $$ = $1; }
;

typeList: { $$ = NULL; }
| typeListP { $$ = $1; }
;
