typedefs: { ; }
| typedefs definTypedef endls { ; }
| definTypedef endls { ; }
;

definTypedef:
TYPEDEF name defineType {
    typed* ctyped = typed_create($2->name, $3);
    if (ctyped != NULL && parsing_step == DEFINE) {
        ctyped->location = $2->location;
        file_add_typed(current_file, ctyped);
    }
}
;
