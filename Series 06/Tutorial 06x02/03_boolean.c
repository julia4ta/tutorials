#include <stdio.h>
#include <stdbool.h>

int main()
{
    // bool requires stdbool.h
    // bool ans = 3 < 2;
    // bool ans = 3 >= 3;
    // bool ans = 4 == 2 * 2;
    // bool ans = 2 * 2 != 4;
    // bool ans = true && false;
    // bool ans = true || false;
    bool ans = false + true;

    printf("%d", ans);

    return 0;
}