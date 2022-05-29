#include <stdio.h>

int main()
{
    int x = 1;
    int y = 2;

    int temp = x;
    x = y;
    y = temp;

    x = y;

    x > y ? printf("%d > %d", x, y) : printf("%d <= %d", x, y);

    return 0;
}