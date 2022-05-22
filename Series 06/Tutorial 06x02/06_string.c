#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main()
{
    // char ans = 'a';
    // printf("%c", ans);

    // char ans[] = "Hello";
    // printf("%s", ans);

    // printf("\nThis is \"great\".\n");
    // printf("\n1\n2\n3\n");
    // printf("\n1\t2\t3\n");

    // char s1[] = "Hello";
    // char s2[] = ", ";
    // char s3[] = "World!";

    // strcat requires string.h
    // strcat(s1, s2);
    // strcat(s1, s3);
    // printf("%s", s1);

    // char s4[] = "Dabbling";
    // printf("\nMy name is %s Doggo.\n", s4);

    // int number123 = 123;
    // char ans[3];
    // sprintf(ans, "%d", number123);
    // printf("%s", ans);

    char string123[] =  "123";

    // atoi requires stdlib.h
    // int ans = atoi(string123);
    // printf("%d", ans);

    // atof requires stdlib.h
    float ans = atof(string123);
    printf("%f", ans);

    return 0;
}