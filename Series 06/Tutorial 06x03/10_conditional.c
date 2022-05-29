#include <stdio.h>

int main()
{
    int x = 1;
    int y = 2;

    int temp = x;
    x = y;
    y = temp;

    x = y;

    if (x > y)
    {
        printf("%d is greater than %d", x, y);
    }
    else if (x < y)
    {
        printf("%d is less than %d", x, y);
    }
    else
    {
        printf("%d is equal to %d", x, y);
    }

    return 0;
}