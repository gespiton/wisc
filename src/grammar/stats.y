stats: { ; }
| stats stat { ; }
| stat { ; }
;

stat:
endc { ; }
| assignment endc { ; }
| controlSpace endc { ; }
| idenFunc endc { ; }
;

defineStats:
defineStats defineStat { ; }
| defineStat { ; }
;

defineStat:
endc { ; }
| defineFunc endc { ; }
| defineVariale endc { ; }
;
