if (!val) return "0";
static char buf[32] = {0};
int i = 30;
for(; val && i ; --i, val /= 10)
	buf[i] = "0123456789"[val % 10];

return &buf[i+1];
