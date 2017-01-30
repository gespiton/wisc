if (target == NULL) return;
if (new_line)
    target->context = merge(4, target->context, "\n", tab(space_parent_num(target) + 2), context);
else target->context = merge(3, target->context, " ", context);
