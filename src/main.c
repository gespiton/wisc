#include <stdio.h>

#include "core.h"

int main(int argc, char* argv[]) {
    if (argc > 1) {
        init();
        start(argv[1]);
    }

    return 0;
}
