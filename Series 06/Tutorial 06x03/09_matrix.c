#include <stdio.h>

int main()
{
    int matrix[2][3] =
    {
        {1, 2, 3},
        {4, 5, 6}
    };

    printf("%d ", matrix[0][0]);
    printf("%d ", matrix[0][1]);
    printf("%d\n", matrix[0][2]);
    printf("%d ", matrix[1][0]);
    printf("%d ", matrix[1][1]);
    printf("%d\n", matrix[1][2]);

    return 0;
}