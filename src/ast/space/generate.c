char* string = "";
if (target->variables != NULL) {
    var* cvar = target->variables;
    for (; cvar != NULL; cvar = cvar->next) {
        if (!cvar->define_func) {
            if (strcmp(string, "") == 0) string = "var ";
            string = concat(string, cvar->gname);
        }
        if (strcmp(string, "") != 0 && cvar->next != NULL && !cvar->next->define_func)
            string = concat(string, ", ");
    }
    string = merge(4, "\n", tab(space_parent_num(target) + 2), string, ";");
}
return merge(8, target->header, " {", target->init, string, target->context, "\n", tab(space_parent_num(target) + 1), "}");
