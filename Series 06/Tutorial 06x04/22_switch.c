#include <stdio.h>

int main()
{
    int direction = 5;

    switch (direction)
    {
    case 1:
        printf("Go North");
        break;
    case 2:
        printf("Go South");
        break;
    case 3:
        printf("Go West");
        break;
    case 4:
        printf("Go East");
        break;
    
    default:
        printf("Stay Still");
        break;
    }

    return 0;
}