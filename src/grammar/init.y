init:
DINIT endls initContext DEND endls { if (parsing_step == DEFINE) inited = 1; }
;

initContext:
initOperator { ; }
;

initOperator:
OPERATOR RBRACE initOperatorContexts LBRACE endls { ; }
;

initOperatorContexts:
initOperatorContexts initOperatorContext { ; }
| initOperatorContext { ; }
;

initOperatorContext:
endls { ; }
| defineType operator defineType ASSIGN name endls {
    if ($1 != NULL && $2 != NULL && $3 != NULL && $5 != NULL && !inited && parsing_step == DEFINE) {
        operator_add(operator_create($2, $1, $3, $5->name));
    }
}
;
