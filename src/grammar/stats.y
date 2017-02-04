stats:
stats stat endc { ; }
| stat endc { ; }
;

stat:
endc { ; }
| iteration { ; }
| controlSpace { ; }
| defineStat { ; }

| defineIf { ; }
| defineWhile { ; }
| defineFor { ; }
| defineSwitch { ; }
;

defineStat:
defineFunc { ; }
| defineVariale { ; }
;
