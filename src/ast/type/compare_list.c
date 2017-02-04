type* t1 = tlist1;
type* t2 = tlist2;
int counting = 1;
for (; t1 != NULL; t1 = t1->next) {
    if (t2 == NULL) return counting;
    else if (!type_compare(t1, NULL, t2))
        return counting;
    counting += 1;
    t2 = t2->next;
}
if (t2 != NULL)
    return counting + 1;
return 0;
