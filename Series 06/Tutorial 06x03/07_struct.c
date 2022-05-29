#include <stdio.h>
#include <string.h>

struct Dog
{
    char name[12];
    int age;
    char breed[12];
};

int main()
{
    struct Dog dog1;

    dog1.age = 2;

    // strcpy() from string.h
    strcpy(dog1.name, "eggdog");
    strcpy(dog1.breed, "egg-dog mix");

    printf("Name:\t%s\n", dog1.name);
    printf("Age:\t%d\n", dog1.age);
    printf("Breed:\t%s\n", dog1.breed);

    strcpy(dog1.name, "Doggo");

    printf("\n");

    printf("Name:\t%s\n", dog1.name);
    printf("Age:\t%d\n", dog1.age);
    printf("Breed:\t%s\n", dog1.breed);

    return 0;
}