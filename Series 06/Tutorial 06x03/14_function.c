#include <stdio.h>

int myadd(int x, int y)
{
    return x + y;
}

int main()
{
    int ans = myadd(2, 3);

    printf("2 + 3 = %d", ans);

    return 0;
}