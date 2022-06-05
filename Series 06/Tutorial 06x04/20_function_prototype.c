#include <stdio.h>

// function declaration
void print_vector(int[], int);
int sum_vector(int[], int);
void sort_vector(int[], int, int);

int main()
{
    int vector[] = {4, 2, 5, 3, 1};

    printf("unsorted vector:\n");
    print_vector(vector, 5);

    printf("\nvector sum:\n");
    int sum = sum_vector(vector, 5);
    printf("%d\n", sum);

    printf("\nsorted vector (ascending):\n");
    sort_vector(vector, 5, 0);

    printf("\nsorted vector (descending):\n");
    sort_vector(vector, 5, 1);

    return 0;
}

// function definition

void print_vector(int vector[], int len)
{
    for (int i = 0; i < len; i++)
    {
        printf("%d\n", vector[i]);
    }
}

int sum_vector(int vector[], int len)
{
    int ans = 0;

    for (int i = 0; i < len; i++)
    {
        ans += vector[i];
    }

    return ans;
}

void sort_vector(int vector[], int len, int reverse)
{
    if (reverse == 1)
    {
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
    }
    else
    {
        // bubble sort algorithm
        for (int i = 0; i < len - 1; i++)
        {
            for (int j = 0; j < len - 1; j++)
            {
                // > for ascend | < for descend
                if (vector[j] > vector[j + 1])
                {
                    int temp = vector[j];
                    vector[j] = vector[j + 1];
                    vector[j + 1] = temp;
                }
            }
        }
    }

    // print sorted vector
    for (int i = 0; i < len; i++)
    {
        printf("%d\n", vector[i]);
    }
}