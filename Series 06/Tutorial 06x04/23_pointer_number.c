#include <stdio.h>

int main()
{
    int ans = 1;

    printf("variable value = %d\n", ans);
    printf("variable address = %p\n", &ans);

    int *pAns = &ans;

    printf("\n");

    printf("pointer value = %p\n", pAns);
    printf("value stored at that address = %d\n", *pAns);

    *pAns = 42;

    printf("\n");

    printf("variable value = %d\n", ans);
    printf("variable address = %p\n", &ans);

    printf("\n");

    printf("pointer value = %p\n", pAns);
    printf("value stored at that address = %d\n", *pAns);

    return 0;
}