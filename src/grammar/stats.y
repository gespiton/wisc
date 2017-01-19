stats:
stats stat { $$ = concat($1, $2); }
| stat { $$ = $1; }
;

stat:
endc { ; }
| defineVariale endc { ; }
| assignment endc { ; }
;
