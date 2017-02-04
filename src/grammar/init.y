init:
DINIT endls initContext DEND { inited = 1; }
;

initContext: { ; }
| initOperator { ; }
;

initOperator:
OPERATOR LBRACE initOperatorContexts RBRACE endls { ; }
;

initOperatorContexts:
initOperatorContexts initOperatorContext { ; }
| initOperatorContext { ; }
;

initOperatorContext:
endls { ; }
| defineType operator defineType ASSIGN name endls {
    if ($1 != NULL && $2 != NULL && $3 != NULL && $5 != NULL && !inited) {
        /*printf("%s %s %s = %s", $1->code, $2, $3->code, $5->name);*/
        operator_add(operator_create($2, $1, $3, $5->name));
    }
}
;
