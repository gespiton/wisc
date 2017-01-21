if (func_header == NULL) return NULL;
type* ntype = type_create(string_create(TYPE_FUNCTION), stype_func(func_header));
if (func_header->params_list != NULL) {
    ntype->code = merge(4,
        func_header->return_type->code,
        "(",
        type_string(param_to_type(func_header->params_list)),
        ")"
    );
} else {
    ntype->code = concat(func_header->return_type->code, "()");
}

return ntype;
