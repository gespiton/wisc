if (root == NULL) root = sub;
else {
    type* otype = sub;
    for (; otype != NULL; otype = otype->multiple) {
        if (type_compare(root, root, otype)) continue;
        type* ctype = root;
        while (ctype->multiple != NULL) ctype = ctype->multiple;
        ctype->multiple = otype;

        if (root != NULL && sub != NULL) {
            root->name = merge(3, root->name, "|", otype->name);
        }
    }
}


return root;
