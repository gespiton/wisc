#include <stdio.h>

#include "core.h"

void check(char* symbol, expr* v1, expr* v2) {
    operator* sopt = operator_search(operator_create(symbol,v1->type,v2->type,""));
    if (sopt != NULL) printf("%s %s %s = %s\n", sopt->left->code, sopt->symbol, sopt->right->code, sopt->output);
}

int main(int argc, char* argv[]) {
    if (argc > 1) {
        init();
        start(argv[1]);
        type* num = type_create(string_create(TYPE_NUMBER), stype_blank());
        type* string = type_create(string_create(TYPE_STRING), stype_blank());
        operator_add(operator_create("+",num,num,TYPE_NUMBER));
        operator_add(operator_create("+",string,num,TYPE_NUMBER));

        // Num + Num
        printf("%s\n", "num + num:");
        check("+", expr_create(
            string_create("3"),
            type_create(string_create(TYPE_NUMBER), stype_blank())
        ), expr_create(
            string_create("10"),
            type_create(string_create(TYPE_NUMBER), stype_blank())
        ));

        // String + Num
        printf("%s\n", "string + num:");
        check("+", expr_create(
            string_create("\"Hello world\""),
            type_create(string_create(TYPE_STRING), stype_blank())
        ), expr_create(
            string_create("10"),
            type_create(string_create(TYPE_NUMBER), stype_blank())
        ));

        // Num + String
        printf("%s\n", "num + string:");
        check("+", expr_create(
            string_create("10"),
            type_create(string_create(TYPE_NUMBER), stype_blank())
        ), expr_create(
            string_create("\"Hello world\""),
            type_create(string_create(TYPE_STRING), stype_blank())
        ));
    }

    return 0;
}
