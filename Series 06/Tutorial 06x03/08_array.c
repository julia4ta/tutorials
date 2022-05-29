#include <stdio.h>

int main()
{
    int scalar[] = {1};

    printf("%d\n", scalar[0]);

    int vector[] = {1, 2, 3};

    printf("\n");

    printf("%d\n", vector[0]);
    printf("%d\n", vector[1]);
    printf("%d\n", vector[2]);

    int ans = vector[1] * 5;

    printf("\n");

    printf("2 * 5 = %d\n", ans);

    int size_vector = sizeof(vector);
    int size_element = sizeof(vector[0]);
    int length = size_vector / size_element;

    printf("\n");

    printf("size of vector = %d\n", size_vector);
    printf("size of element = %d\n", size_element);
    printf("elements in vector = %d\n", length);

    vector[3] = 4;

    printf("\n");

    printf("%d\n", vector[0]);
    printf("%d\n", vector[1]);
    printf("%d\n", vector[2]);
    printf("%d\n", vector[3]);

    size_vector = sizeof(vector);
    size_element = sizeof(vector[0]);
    length = size_vector / size_element;

    printf("\n");

    printf("size of vector = %d\n", size_vector);
    printf("size of element = %d\n", size_element);
    printf("elements in vector = %d\n", length);

    return 0;
}