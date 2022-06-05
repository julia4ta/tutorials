#include <stdio.h>

int main()
{
    int vector[] = {1, 2, 3, 4, 5};

    int len = sizeof(vector) / sizeof(vector[0]);

    int ans = 0;

    for (int i = 0; i < len; i++)
    {
        ans += vector[i];
    }

    printf("sum = %d\n", ans);
    
    return 0;
}