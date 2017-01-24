stats: { ; }
| stats stat { ; }
| stat { ; }
;

stat:
endc { ; }
| iteration endc { ; }
| controlSpace endc { ; }
| idenFunc endc { ; }

| defineIf endc { ; }
| defineWhile endc { ; }
| defineFor endc { ; }
| defineSwitch endc { ; }
;

defineStats: { ; }
| defineStats defineStat { ; }
| defineStat { ; }
;

defineStat:
endc { ; }
| defineFunc endc { ; }
| defineVariale endc { ; }
;
