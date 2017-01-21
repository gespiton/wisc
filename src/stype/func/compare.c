// 0 is equal, 1 is type not equal, n (n > 1) param number not equal
if (type_compare(func1->return_type, func2->return_type)) {
    int result = type_compare_list(param_to_type(func1->params_list), param_to_type(func2->params_list));
    if (result) return result + 1;
    else return 0;
} else return 1;
