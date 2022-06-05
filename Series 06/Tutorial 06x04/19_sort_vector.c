#include <stdio.h>

int main()
{
    int vector[] = {4, 2, 5, 3, 1};

    int len = sizeof(vector) / sizeof(vector[0]);

    // bubble sort algorithm
    for (int i = 0; i < len - 1; i++)
    {
        for (int j = 0; j < len - 1; j++)
        {
            // > for ascend | < for descend
            if (vector[j] < vector[j + 1])
            {
                int temp = vector[j];
                vector[j] = vector[j + 1];
                vector[j + 1] = temp;
            }
        }
    }
    
    // print sorted vector
    for (int i = 0; i < len; i++)
    {
        printf("%d\n", vector[i]);
    }
    
    return 0;
}